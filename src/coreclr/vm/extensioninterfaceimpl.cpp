// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#include "common.h"
#include "extensioninterfaceimpl.h"

#include "caparser.h"
#include "clsload.hpp"
#include "typedesc.h"

// Prototype metadata encoding. Each module-level ExtensionInterfaceImplAttribute
// contains the fixed arguments below. Target and contract are ordinary CLI type
// signatures interpreted in the witness type's generic context. The attribute is
// replaced by the ExtensionInterfaceImpl table when standard table numbers exist.
//
//   int32 ownerTypeDef
//   int32 implementationTypeDef
//   byte[] target
//   byte[] contract
//   uint16 flags
//
// Each module-level ExtensionInterfaceMethodImplAttribute contains:
//
//   int32 implementationTypeDef
//   int32 declarationMethodDefOrRef
//   int32 canonicalBodyMethodDef

namespace
{
    enum ExtensionInterfaceImplFlags : UINT16
    {
        ExtensionInterfaceImpl_TypeOwned = 0x0001,
        ExtensionInterfaceImpl_InterfaceOwned = 0x0002,
    };

    struct ManifestRow
    {
        mdTypeDef owner;
        mdTypeDef implementation;
        PCCOR_SIGNATURE targetSignature;
        ULONG targetSignatureSize;
        PCCOR_SIGNATURE interfaceSignature;
        ULONG interfaceSignatureSize;
        UINT16 flags;
    };

    struct MethodManifestRow
    {
        mdTypeDef implementation;
        mdToken declaration;
        mdMethodDef body;
    };

    struct RowReference
    {
        mdTypeDef key;
        UINT32 rowIndex;
    };

    struct MethodIndex
    {
        MethodManifestRow* rows;
        RowReference* implementationReferences;
        UINT32 rowCount;
    };

    struct ModuleIndex
    {
        ManifestRow* rows;
        RowReference* ownerReferences;
        UINT32 rowCount;
        UINT32 ownerReferenceCount;
        Volatile<TADDR> methodIndex;

        ModuleIndex()
            : rows(nullptr), ownerReferences(nullptr), rowCount(0), ownerReferenceCount(0), methodIndex{}
        {
            LIMITED_METHOD_CONTRACT;
        }
    };

    [[noreturn]] void ThrowInvalidManifest()
    {
        COMPlusThrow(kTypeLoadException, IDS_CLASSLOAD_BADFORMAT);
    }

    void ReadByteArray(CustomAttributeParser* pParser, CQuickBytes* pBuffer, ULONG* pSize)
    {
        UINT32 size;
        if (FAILED(pParser->GetU4(&size)) || size == UINT32_MAX || size > static_cast<UINT32>(pParser->BytesLeft()))
        {
            ThrowInvalidManifest();
        }

        BYTE* pBytes = static_cast<BYTE*>(pBuffer->AllocThrows(size));
        for (UINT32 i = 0; i < size; i++)
        {
            if (FAILED(pParser->GetU1(&pBytes[i])))
            {
                ThrowInvalidManifest();
            }
        }

        *pSize = size;
    }

    void ValidateTypeSignature(PCCOR_SIGNATURE signature, ULONG signatureSize)
    {
        SigParser parser(signature, signatureSize);
        if (FAILED(parser.SkipExactlyOne()))
        {
            ThrowInvalidManifest();
        }

        PCCOR_SIGNATURE remainingSignature;
        UINT32 remainingSize;
        parser.GetSignature(&remainingSignature, &remainingSize);
        if (remainingSize != 0)
        {
            ThrowInvalidManifest();
        }
    }

    void ParseManifestRow(
        const void* pBlob,
        ULONG blobSize,
        ManifestRow* pRow,
        CQuickBytes* pTargetSignature,
        CQuickBytes* pInterfaceSignature)
    {
        CustomAttributeParser parser(pBlob, blobSize);
        INT32 owner;
        INT32 implementation;
        UINT16 namedArgumentCount;

        if (FAILED(parser.ValidateProlog()) ||
            FAILED(parser.GetI4(&owner)) ||
            FAILED(parser.GetI4(&implementation)))
        {
            ThrowInvalidManifest();
        }

        pRow->owner = static_cast<mdTypeDef>(owner);
        pRow->implementation = static_cast<mdTypeDef>(implementation);
        ReadByteArray(&parser, pTargetSignature, &pRow->targetSignatureSize);
        ReadByteArray(&parser, pInterfaceSignature, &pRow->interfaceSignatureSize);
        pRow->targetSignature = static_cast<PCCOR_SIGNATURE>(pTargetSignature->Ptr());
        pRow->interfaceSignature = static_cast<PCCOR_SIGNATURE>(pInterfaceSignature->Ptr());
        ValidateTypeSignature(pRow->targetSignature, pRow->targetSignatureSize);
        ValidateTypeSignature(pRow->interfaceSignature, pRow->interfaceSignatureSize);

        if (FAILED(parser.GetU2(&pRow->flags)) ||
            FAILED(parser.GetU2(&namedArgumentCount)) ||
            namedArgumentCount != 0 ||
            parser.BytesLeft() != 0 ||
            TypeFromToken(pRow->owner) != mdtTypeDef ||
            IsNilToken(pRow->owner) ||
            TypeFromToken(pRow->implementation) != mdtTypeDef ||
            IsNilToken(pRow->implementation) ||
            (pRow->flags != ExtensionInterfaceImpl_TypeOwned &&
             pRow->flags != ExtensionInterfaceImpl_InterfaceOwned))
        {
            ThrowInvalidManifest();
        }
    }

    void ParseMethodManifestRow(const void* pBlob, ULONG blobSize, MethodManifestRow* pRow)
    {
        CustomAttributeParser parser(pBlob, blobSize);
        INT32 implementation;
        INT32 declaration;
        INT32 body;
        UINT16 namedArgumentCount;

        if (FAILED(parser.ValidateProlog()) ||
            FAILED(parser.GetI4(&implementation)) ||
            FAILED(parser.GetI4(&declaration)) ||
            FAILED(parser.GetI4(&body)) ||
            FAILED(parser.GetU2(&namedArgumentCount)) ||
            namedArgumentCount != 0 ||
            parser.BytesLeft() != 0)
        {
            ThrowInvalidManifest();
        }

        pRow->implementation = static_cast<mdTypeDef>(implementation);
        pRow->declaration = static_cast<mdToken>(declaration);
        pRow->body = static_cast<mdMethodDef>(body);

        ULONG32 declarationType = TypeFromToken(pRow->declaration);
        if (TypeFromToken(pRow->implementation) != mdtTypeDef ||
            IsNilToken(pRow->implementation) ||
            (declarationType != mdtMethodDef && declarationType != mdtMemberRef) ||
            IsNilToken(pRow->declaration) ||
            TypeFromToken(pRow->body) != mdtMethodDef ||
            IsNilToken(pRow->body))
        {
            ThrowInvalidManifest();
        }
    }

    bool TryGetLocalTypeDefFromSignature(Module* pModule, mdToken token, mdTypeDef* pTypeDef)
    {
        LIMITED_METHOD_CONTRACT;

        if (TypeFromToken(token) == mdtTypeDef)
        {
            *pTypeDef = static_cast<mdTypeDef>(token);
            return true;
        }

        if (TypeFromToken(token) != mdtTypeSpec)
        {
            return false;
        }

        PCCOR_SIGNATURE pSignature;
        ULONG signatureSize;
        if (FAILED(pModule->GetMDImport()->GetSigFromToken(token, &signatureSize, &pSignature)))
        {
            return false;
        }

        SigParser parser(pSignature, signatureSize);
        CorElementType elementType;
        if (FAILED(parser.GetElemType(&elementType)))
        {
            return false;
        }

        if (elementType == ELEMENT_TYPE_GENERICINST && FAILED(parser.GetElemType(&elementType)))
        {
            return false;
        }

        if (elementType != ELEMENT_TYPE_CLASS && elementType != ELEMENT_TYPE_VALUETYPE)
        {
            return false;
        }

        mdToken rootToken;
        if (FAILED(parser.GetToken(&rootToken)) || TypeFromToken(rootToken) != mdtTypeDef)
        {
            return false;
        }

        *pTypeDef = static_cast<mdTypeDef>(rootToken);
        return true;
    }

    bool ContainsTypeDef(const StackSArray<mdTypeDef>& types, mdTypeDef type)
    {
        LIMITED_METHOD_CONTRACT;

        for (COUNT_T i = 0; i < types.GetCount(); i++)
        {
            if (types[i] == type)
            {
                return true;
            }
        }

        return false;
    }

    void AppendInterfaceOwnerReferences(
        Module* pModule,
        mdTypeDef interfaceType,
        UINT32 rowIndex,
        StackSArray<mdTypeDef>* pVisited,
        StackSArray<RowReference>* pReferences,
        UINT32 depth = 0)
    {
        CONTRACTL
        {
            THROWS;
            GC_NOTRIGGER;
            MODE_ANY;
        }
        CONTRACTL_END;

        if (ContainsTypeDef(*pVisited, interfaceType))
        {
            return;
        }

        pVisited->Append(interfaceType);
        pReferences->Append(RowReference{interfaceType, rowIndex});
        if (depth == 64)
        {
            return;
        }

        IMDInternalImport* pImport = pModule->GetMDImport();
        HENUMInternalHolder hEnum(pImport);
        hEnum.EnumInit(mdtInterfaceImpl, interfaceType);

        mdInterfaceImpl interfaceImpl;
        while (pImport->EnumNext(&hEnum, &interfaceImpl))
        {
            mdToken implementedInterface;
            if (FAILED(pImport->GetTypeOfInterfaceImpl(interfaceImpl, &implementedInterface)))
            {
                continue;
            }

            mdTypeDef implementedInterfaceTypeDef;
            if (TryGetLocalTypeDefFromSignature(pModule, implementedInterface, &implementedInterfaceTypeDef))
            {
                AppendInterfaceOwnerReferences(
                    pModule,
                    implementedInterfaceTypeDef,
                    rowIndex,
                    pVisited,
                    pReferences,
                    depth + 1);
            }
        }
    }

    int __cdecl CompareRowReferences(const void* pLeft, const void* pRight)
    {
        LIMITED_METHOD_CONTRACT;

        const RowReference& left = *static_cast<const RowReference*>(pLeft);
        const RowReference& right = *static_cast<const RowReference*>(pRight);
        if (left.key != right.key)
        {
            return left.key < right.key ? -1 : 1;
        }

        if (left.rowIndex == right.rowIndex)
        {
            return 0;
        }

        return left.rowIndex < right.rowIndex ? -1 : 1;
    }

    PCCOR_SIGNATURE CopySignature(
        LoaderHeap* pHeap,
        AllocMemTracker* pTracker,
        PCCOR_SIGNATURE pSignature,
        ULONG signatureSize)
    {
        CONTRACTL
        {
            THROWS;
            GC_NOTRIGGER;
            MODE_ANY;
        }
        CONTRACTL_END;

        BYTE* pCopy = static_cast<BYTE*>(pTracker->Track(pHeap->AllocMem(S_SIZE_T(signatureSize))));
        memcpy(pCopy, pSignature, signatureSize);
        return pCopy;
    }

    ModuleIndex* BuildModuleIndex(Module* pModule, AllocMemTracker* pTracker)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        IMDInternalImport* pImport = pModule->GetMDImport();
        MDEnumHolder hEnum(pImport);
        IfFailThrow(pImport->EnumCustomAttributeByNameInit(
            TokenFromRid(1, mdtModule),
            g_ExtensionInterfaceImplAttribute,
            &hEnum));

        UINT32 rowCount = pImport->EnumGetCount(&hEnum);
        LoaderHeap* pHeap = pModule->GetLoaderAllocator()->GetLowFrequencyHeap();
        ModuleIndex* pIndex = static_cast<ModuleIndex*>(pTracker->Track(pHeap->AllocMem(S_SIZE_T(sizeof(ModuleIndex)))));
        new (pIndex) ModuleIndex();

        if (rowCount != 0)
        {
            pIndex->rows = static_cast<ManifestRow*>(
                pTracker->Track(pHeap->AllocMem(S_SIZE_T(rowCount) * S_SIZE_T(sizeof(ManifestRow)))));
        }
        pIndex->rowCount = rowCount;

        UINT32 rowIndex = 0;
        mdCustomAttribute attribute;
        while (pImport->EnumNext(&hEnum, &attribute))
        {
            _ASSERTE(rowIndex < rowCount);

            const void* pBlob;
            ULONG blobSize;
            IfFailThrow(pImport->GetCustomAttributeAsBlob(attribute, &pBlob, &blobSize));

            CQuickBytes targetSignature;
            CQuickBytes interfaceSignature;
            ManifestRow& row = pIndex->rows[rowIndex++];
            ParseManifestRow(pBlob, blobSize, &row, &targetSignature, &interfaceSignature);

            DWORD ownerAttributes;
            DWORD implementationAttributes;
            if (!pImport->IsValidToken(row.owner) ||
                !pImport->IsValidToken(row.implementation) ||
                FAILED(pImport->GetTypeDefProps(row.owner, &ownerAttributes, NULL)) ||
                FAILED(pImport->GetTypeDefProps(row.implementation, &implementationAttributes, NULL)) ||
                !IsTdInterface(implementationAttributes) ||
                (row.flags == ExtensionInterfaceImpl_InterfaceOwned && !IsTdInterface(ownerAttributes)))
            {
                ThrowInvalidManifest();
            }

            row.targetSignature = CopySignature(
                pHeap,
                pTracker,
                row.targetSignature,
                row.targetSignatureSize);
            row.interfaceSignature = CopySignature(
                pHeap,
                pTracker,
                row.interfaceSignature,
                row.interfaceSignatureSize);
        }
        _ASSERTE(rowIndex == rowCount);

        StackSArray<RowReference> ownerReferences;
        for (rowIndex = 0; rowIndex < rowCount; rowIndex++)
        {
            const ManifestRow& row = pIndex->rows[rowIndex];
            if (row.flags == ExtensionInterfaceImpl_TypeOwned)
            {
                ownerReferences.Append(RowReference{row.owner, rowIndex});
                continue;
            }

            StackSArray<mdTypeDef> visited;
            AppendInterfaceOwnerReferences(
                pModule,
                row.owner,
                rowIndex,
                &visited,
                &ownerReferences);
        }

        if (ownerReferences.GetCount() > UINT32_MAX)
        {
            ThrowInvalidManifest();
        }

        pIndex->ownerReferenceCount = static_cast<UINT32>(ownerReferences.GetCount());
        if (pIndex->ownerReferenceCount != 0)
        {
            pIndex->ownerReferences = static_cast<RowReference*>(pTracker->Track(
                pHeap->AllocMem(S_SIZE_T(pIndex->ownerReferenceCount) * S_SIZE_T(sizeof(RowReference)))));
            memcpy(
                pIndex->ownerReferences,
                ownerReferences.GetElements(),
                pIndex->ownerReferenceCount * sizeof(RowReference));
            qsort(
                pIndex->ownerReferences,
                pIndex->ownerReferenceCount,
                sizeof(RowReference),
                CompareRowReferences);
        }

        return pIndex;
    }

    ModuleIndex* GetModuleIndex(Module* pModule)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        TADDR currentIndex = pModule->GetExtensionInterfaceIndex();
        if (currentIndex != 0)
        {
            return reinterpret_cast<ModuleIndex*>(currentIndex);
        }

        AllocMemTracker tracker;
        ModuleIndex* pNewIndex = BuildModuleIndex(pModule, &tracker);
        if (pModule->TrySetExtensionInterfaceIndex(reinterpret_cast<TADDR>(pNewIndex)))
        {
            tracker.SuppressRelease();
            return pNewIndex;
        }

        return reinterpret_cast<ModuleIndex*>(pModule->GetExtensionInterfaceIndex());
    }

    MethodIndex* BuildMethodIndex(Module* pModule, AllocMemTracker* pTracker)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        IMDInternalImport* pImport = pModule->GetMDImport();
        MDEnumHolder hEnum(pImport);
        IfFailThrow(pImport->EnumCustomAttributeByNameInit(
            TokenFromRid(1, mdtModule),
            g_ExtensionInterfaceMethodImplAttribute,
            &hEnum));

        UINT32 rowCount = pImport->EnumGetCount(&hEnum);
        LoaderHeap* pHeap = pModule->GetLoaderAllocator()->GetLowFrequencyHeap();
        MethodIndex* pIndex = static_cast<MethodIndex*>(pTracker->Track(pHeap->AllocMem(S_SIZE_T(sizeof(MethodIndex)))));
        pIndex->rows = nullptr;
        pIndex->implementationReferences = nullptr;
        pIndex->rowCount = rowCount;

        if (rowCount != 0)
        {
            pIndex->rows = static_cast<MethodManifestRow*>(
                pTracker->Track(pHeap->AllocMem(S_SIZE_T(rowCount) * S_SIZE_T(sizeof(MethodManifestRow)))));
            pIndex->implementationReferences = static_cast<RowReference*>(
                pTracker->Track(pHeap->AllocMem(S_SIZE_T(rowCount) * S_SIZE_T(sizeof(RowReference)))));
        }

        UINT32 rowIndex = 0;
        mdCustomAttribute attribute;
        while (pImport->EnumNext(&hEnum, &attribute))
        {
            _ASSERTE(rowIndex < rowCount);

            const void* pBlob;
            ULONG blobSize;
            IfFailThrow(pImport->GetCustomAttributeAsBlob(attribute, &pBlob, &blobSize));

            MethodManifestRow& row = pIndex->rows[rowIndex];
            ParseMethodManifestRow(pBlob, blobSize, &row);
            if (!pImport->IsValidToken(row.implementation) ||
                !pImport->IsValidToken(row.declaration) ||
                !pImport->IsValidToken(row.body))
            {
                ThrowInvalidManifest();
            }

            pIndex->implementationReferences[rowIndex] = RowReference{row.implementation, rowIndex};
            rowIndex++;
        }
        _ASSERTE(rowIndex == rowCount);

        if (rowCount > 1)
        {
            qsort(
                pIndex->implementationReferences,
                rowCount,
                sizeof(RowReference),
                CompareRowReferences);
        }

        return pIndex;
    }

    MethodIndex* GetMethodIndex(Module* pModule)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        ModuleIndex* pModuleIndex = GetModuleIndex(pModule);
        TADDR currentIndex = pModuleIndex->methodIndex;
        if (currentIndex != 0)
        {
            return reinterpret_cast<MethodIndex*>(currentIndex);
        }

        AllocMemTracker tracker;
        MethodIndex* pNewIndex = BuildMethodIndex(pModule, &tracker);
        currentIndex = InterlockedCompareExchangeT(
            &pModuleIndex->methodIndex,
            reinterpret_cast<TADDR>(pNewIndex),
            (TADDR)0);
        if (currentIndex == 0)
        {
            tracker.SuppressRelease();
            return pNewIndex;
        }

        return reinterpret_cast<MethodIndex*>(currentIndex);
    }

    UINT32 FindFirstRowReference(const RowReference* pReferences, UINT32 referenceCount, mdTypeDef key)
    {
        LIMITED_METHOD_CONTRACT;

        UINT32 low = 0;
        UINT32 high = referenceCount;
        while (low < high)
        {
            UINT32 middle = low + ((high - low) / 2);
            if (pReferences[middle].key < key)
            {
                low = middle + 1;
            }
            else
            {
                high = middle;
            }
        }

        return low;
    }

    template <typename TAction>
    void ForEachManifestRow(Module* pModule, mdTypeDef owner, TAction action)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        ModuleIndex* pIndex = GetModuleIndex(pModule);
        UINT32 referenceIndex = FindFirstRowReference(
            pIndex->ownerReferences,
            pIndex->ownerReferenceCount,
            owner);
        while (referenceIndex < pIndex->ownerReferenceCount &&
               pIndex->ownerReferences[referenceIndex].key == owner)
        {
            action(pIndex->rows[pIndex->ownerReferences[referenceIndex].rowIndex]);
            referenceIndex++;
        }
    }

    template <typename TAction>
    void ForEachMethodManifestRow(Module* pModule, mdTypeDef implementation, TAction action)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        MethodIndex* pIndex = GetMethodIndex(pModule);
        UINT32 referenceIndex = FindFirstRowReference(
            pIndex->implementationReferences,
            pIndex->rowCount,
            implementation);
        while (referenceIndex < pIndex->rowCount &&
               pIndex->implementationReferences[referenceIndex].key == implementation)
        {
            action(pIndex->rows[pIndex->implementationReferences[referenceIndex].rowIndex]);
            referenceIndex++;
        }
    }

    enum class SignatureRootKind
    {
        Invalid,
        TypeVariable,
        Nominal,
    };

    SignatureRootKind GetSignatureRoot(
        Module* pModule,
        PCCOR_SIGNATURE pSignature,
        ULONG signatureSize,
        TypeHandle* pRootType,
        UINT32* pTypeVariableIndex = nullptr)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        SigParser parser(pSignature, signatureSize);
        CorElementType elementType;
        if (FAILED(parser.GetElemType(&elementType)))
        {
            ThrowInvalidManifest();
        }

        if (elementType == ELEMENT_TYPE_VAR)
        {
            UINT32 index;
            if (FAILED(parser.GetData(&index)))
            {
                ThrowInvalidManifest();
            }

            if (pTypeVariableIndex != nullptr)
            {
                *pTypeVariableIndex = index;
            }
            return SignatureRootKind::TypeVariable;
        }

        if (elementType == ELEMENT_TYPE_GENERICINST && FAILED(parser.GetElemType(&elementType)))
        {
            ThrowInvalidManifest();
        }

        if (elementType != ELEMENT_TYPE_CLASS && elementType != ELEMENT_TYPE_VALUETYPE)
        {
            return SignatureRootKind::Invalid;
        }

        mdToken token;
        if (FAILED(parser.GetToken(&token)))
        {
            ThrowInvalidManifest();
        }

        *pRootType = ClassLoader::LoadTypeDefOrRefThrowing(
            pModule,
            token,
            ClassLoader::ThrowIfNotFound,
            ClassLoader::PermitUninstDefOrRef);
        return SignatureRootKind::Nominal;
    }

    bool MatchType(
        SigParser* pPattern,
        Module* pModule,
        TypeHandle actualType,
        TypeHandle* pBindings,
        UINT32 bindingCount)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        CorElementType elementType;
        if (FAILED(pPattern->GetElemType(&elementType)))
        {
            ThrowInvalidManifest();
        }

        switch (elementType)
        {
            case ELEMENT_TYPE_VAR:
            {
                UINT32 index;
                if (FAILED(pPattern->GetData(&index)) || index >= bindingCount)
                {
                    ThrowInvalidManifest();
                }

                if (pBindings[index].IsNull())
                {
                    pBindings[index] = actualType;
                    return true;
                }

                return pBindings[index] == actualType;
            }

            case ELEMENT_TYPE_MVAR:
                ThrowInvalidManifest();

            case ELEMENT_TYPE_CLASS:
            case ELEMENT_TYPE_VALUETYPE:
            {
                mdToken token;
                if (FAILED(pPattern->GetToken(&token)))
                {
                    ThrowInvalidManifest();
                }

                TypeHandle patternType = ClassLoader::LoadTypeDefOrRefThrowing(
                    pModule,
                    token,
                    ClassLoader::ThrowIfNotFound,
                    ClassLoader::PermitUninstDefOrRef);

                if (actualType.IsTypeDesc() || patternType.IsTypeDesc())
                {
                    return actualType == patternType;
                }

                MethodTable* pActualMT = actualType.AsMethodTable();
                MethodTable* pPatternMT = patternType.AsMethodTable();
                return pActualMT->HasSameTypeDefAs(pPatternMT) &&
                    actualType.GetInstantiation().IsEmpty() &&
                    patternType.GetInstantiation().IsEmpty();
            }

            case ELEMENT_TYPE_GENERICINST:
            {
                CorElementType genericTypeKind;
                mdToken genericTypeToken;
                UINT32 argumentCount;
                if (FAILED(pPattern->GetElemType(&genericTypeKind)) ||
                    (genericTypeKind != ELEMENT_TYPE_CLASS && genericTypeKind != ELEMENT_TYPE_VALUETYPE) ||
                    FAILED(pPattern->GetToken(&genericTypeToken)) ||
                    FAILED(pPattern->GetData(&argumentCount)))
                {
                    ThrowInvalidManifest();
                }

                if (actualType.IsTypeDesc())
                {
                    return false;
                }

                TypeHandle genericType = ClassLoader::LoadTypeDefOrRefThrowing(
                    pModule,
                    genericTypeToken,
                    ClassLoader::ThrowIfNotFound,
                    ClassLoader::PermitUninstDefOrRef);
                Instantiation actualInstantiation = actualType.GetInstantiation();
                if (genericType.IsTypeDesc() ||
                    !actualType.AsMethodTable()->HasSameTypeDefAs(genericType.AsMethodTable()) ||
                    actualInstantiation.GetNumArgs() != argumentCount)
                {
                    return false;
                }

                for (UINT32 i = 0; i < argumentCount; i++)
                {
                    if (!MatchType(pPattern, pModule, actualInstantiation[i], pBindings, bindingCount))
                    {
                        return false;
                    }
                }

                return true;
            }

            case ELEMENT_TYPE_SZARRAY:
                return actualType.GetSignatureCorElementType() == ELEMENT_TYPE_SZARRAY &&
                    MatchType(pPattern, pModule, actualType.GetArrayElementTypeHandle(), pBindings, bindingCount);

            case ELEMENT_TYPE_OBJECT:
                return actualType.IsObjectType();

            case ELEMENT_TYPE_STRING:
                return actualType.IsString();

            case ELEMENT_TYPE_BOOLEAN:
            case ELEMENT_TYPE_CHAR:
            case ELEMENT_TYPE_I1:
            case ELEMENT_TYPE_U1:
            case ELEMENT_TYPE_I2:
            case ELEMENT_TYPE_U2:
            case ELEMENT_TYPE_I4:
            case ELEMENT_TYPE_U4:
            case ELEMENT_TYPE_I8:
            case ELEMENT_TYPE_U8:
            case ELEMENT_TYPE_R4:
            case ELEMENT_TYPE_R8:
            case ELEMENT_TYPE_I:
            case ELEMENT_TYPE_U:
                return actualType.GetSignatureCorElementType() == elementType;

            default:
                ThrowInvalidManifest();
        }
    }

    bool MatchTarget(
        const ManifestRow& row,
        Module* pModule,
        TypeHandle projection,
        TypeHandle* pBindings,
        UINT32 bindingCount)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        SigParser pattern(
            row.targetSignature,
            row.targetSignatureSize);
        if (!MatchType(&pattern, pModule, projection, pBindings, bindingCount))
        {
            return false;
        }

        PCCOR_SIGNATURE remainingSignature;
        UINT32 remainingSize;
        pattern.GetSignature(&remainingSignature, &remainingSize);
        return remainingSize == 0;
    }

    bool SatisfiesWitnessConstraints(TypeHandle witnessDefinition, Instantiation witnessInstantiation)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        Instantiation formalInstantiation = witnessDefinition.GetInstantiation();
        _ASSERTE(formalInstantiation.GetNumArgs() == witnessInstantiation.GetNumArgs());
        SigTypeContext typeContext(witnessInstantiation, Instantiation());

        for (UINT32 i = 0; i < formalInstantiation.GetNumArgs(); i++)
        {
            if (!formalInstantiation[i].AsGenericVariable()->SatisfiesConstraints(
                    &typeContext,
                    witnessInstantiation[i]))
            {
                return false;
            }
        }

        return true;
    }

    bool HasMarker(MethodTable* pWitnessMT)
    {
        CONTRACTL
        {
            THROWS;
            GC_NOTRIGGER;
            MODE_ANY;
        }
        CONTRACTL_END;

        HRESULT hr = pWitnessMT->GetModule()->GetMDImport()->GetCustomAttributeByName(
            pWitnessMT->GetCl(),
            g_ExtensionInterfaceImplementationAttribute,
            NULL,
            NULL);
        IfFailThrow(hr);
        return hr == S_OK;
    }

    bool ValidateInterfaceOwnedBaseClosure(MethodTable* pDeclaredInterfaceMT)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        Module* pModule = pDeclaredInterfaceMT->GetModule();
        MethodTable::InterfaceMapIterator iterator = pDeclaredInterfaceMT->IterateInterfaceMap();
        while (iterator.Next())
        {
            if (iterator.GetInterface(pDeclaredInterfaceMT)->GetModule() != pModule)
            {
                return false;
            }
        }

        return true;
    }

    bool SameSignatureType(MetaSig* pLeft, MetaSig* pRight)
    {
        WRAPPER_NO_CONTRACT;

        CorElementType leftType = pLeft->NextArg();
        CorElementType rightType = pRight->NextArg();
        if (leftType != rightType)
        {
            return false;
        }

        return CorTypeInfo::IsPrimitiveType(leftType) ||
            pLeft->GetLastTypeHandleThrowing().IsEquivalentTo(pRight->GetLastTypeHandleThrowing());
    }

    bool SameReturnType(MetaSig* pLeft, MetaSig* pRight)
    {
        WRAPPER_NO_CONTRACT;

        CorElementType leftType = pLeft->GetReturnType();
        CorElementType rightType = pRight->GetReturnType();
        if (leftType != rightType)
        {
            return false;
        }

        return CorTypeInfo::IsPrimitiveType(leftType) ||
            pLeft->GetRetTypeHandleThrowing().IsEquivalentTo(pRight->GetRetTypeHandleThrowing());
    }

    MethodDesc* ResolveDeclarationMethod(
        Module* pModule,
        const MethodManifestRow& row,
        MethodTable* pWitnessMT,
        MethodTable* pInterfaceMT,
        MethodDesc* pInterfaceMD)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        MethodDesc* pDeclarationMD;
        if (TypeFromToken(row.declaration) == mdtMethodDef)
        {
            pDeclarationMD = MemberLoader::GetMethodDescFromMethodDef(
                pModule,
                row.declaration,
                FALSE,
                CLASS_LOAD_EXACTPARENTS);
            if (!pDeclarationMD->GetMethodTable()->HasSameTypeDefAs(pInterfaceMT))
            {
                return nullptr;
            }

            pDeclarationMD = MethodDesc::FindOrCreateAssociatedMethodDesc(
                pDeclarationMD,
                pInterfaceMT,
                FALSE,
                pInterfaceMD->GetMethodInstantiation(),
                FALSE);
        }
        else
        {
            SigTypeContext signatureContext(pWitnessMT);
            pDeclarationMD = MemberLoader::GetMethodDescFromMemberDefOrRefOrSpec(
                pModule,
                row.declaration,
                &signatureContext,
                FALSE,
                FALSE,
                CLASS_LOAD_EXACTPARENTS);

            if (pDeclarationMD->GetNumGenericMethodArgs() != pInterfaceMD->GetNumGenericMethodArgs())
            {
                return nullptr;
            }

            pDeclarationMD = MethodDesc::FindOrCreateAssociatedMethodDesc(
                pDeclarationMD->StripMethodInstantiation(),
                pDeclarationMD->GetMethodTable(),
                FALSE,
                pInterfaceMD->GetMethodInstantiation(),
                FALSE);
        }

        if (pDeclarationMD->GetMethodTable() != pInterfaceMT ||
            !pDeclarationMD->HasSameMethodDefAs(pInterfaceMD))
        {
            return nullptr;
        }

        return pDeclarationMD;
    }

    bool ValidateCanonicalBodySignature(
        MethodTable* pTargetMT,
        MethodTable* pWitnessMT,
        MethodTable* pInterfaceMT,
        MethodDesc* pInterfaceMD,
        MethodDesc* pBodyMD)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        if (!pInterfaceMD->IsInterface() || !pInterfaceMD->IsVirtual() ||
            !pInterfaceMD->GetMethodTable()->HasSameTypeDefAs(pInterfaceMT) ||
            !pBodyMD->IsStatic() || pBodyMD->IsAbstract() ||
            pBodyMD->GetNumGenericMethodArgs() != pInterfaceMD->GetNumGenericMethodArgs())
        {
            return false;
        }

        MetaSig declarationSignature(pInterfaceMD, TypeHandle(pInterfaceMT));
        MetaSig bodySignature(pBodyMD, TypeHandle(pWitnessMT));

        if (pInterfaceMD->IsStatic())
        {
            return MetaSig::CompareMethodSigs(declarationSignature, bodySignature, FALSE);
        }

        if (!declarationSignature.HasThis() || bodySignature.HasThis() ||
            bodySignature.NumFixedArgs() != declarationSignature.NumFixedArgs() + 1 ||
            !SameReturnType(&declarationSignature, &bodySignature))
        {
            return false;
        }

        CorElementType receiverType = bodySignature.NextArg();
        TypeHandle receiverTypeHandle;
        if (pTargetMT->IsValueType())
        {
            if (receiverType != ELEMENT_TYPE_BYREF)
            {
                return false;
            }

            CorElementType byRefType = bodySignature.GetByRefType(&receiverTypeHandle);
            if (CorIsPrimitiveType(byRefType))
            {
                receiverTypeHandle = TypeHandle(CoreLibBinder::GetElementType(byRefType));
            }
        }
        else
        {
            if (receiverType == ELEMENT_TYPE_BYREF || CorTypeInfo::IsPrimitiveType(receiverType))
            {
                return false;
            }

            receiverTypeHandle = bodySignature.GetLastTypeHandleThrowing();
        }

        if (!receiverTypeHandle.IsEquivalentTo(TypeHandle(pTargetMT)))
        {
            return false;
        }

        for (UINT32 i = 0; i < declarationSignature.NumFixedArgs(); i++)
        {
            if (!SameSignatureType(&declarationSignature, &bodySignature))
            {
                return false;
            }
        }

        return true;
    }

    bool FindCanonicalBody(
        MethodTable* pTargetMT,
        MethodTable* pWitnessMT,
        MethodTable* pInterfaceMT,
        MethodDesc* pInterfaceMD,
        MethodDesc** ppBodyMD)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        GCX_PREEMP();

        *ppBodyMD = nullptr;
        Module* pModule = pWitnessMT->GetModule();
        ForEachMethodManifestRow(pModule, pWitnessMT->GetCl(), [&](const MethodManifestRow& row)
        {
            if (row.implementation != pWitnessMT->GetCl())
            {
                return;
            }

            MethodDesc* pDeclarationMD = ResolveDeclarationMethod(
                pModule,
                row,
                pWitnessMT,
                pInterfaceMT,
                pInterfaceMD);
            if (pDeclarationMD == nullptr)
            {
                return;
            }

            MethodDesc* pBodyDefinition = MemberLoader::GetMethodDescFromMethodDef(
                pModule,
                row.body,
                FALSE,
                CLASS_LOAD_EXACTPARENTS);
            if (pBodyDefinition->GetMethodTable()->GetModule() != pModule ||
                pBodyDefinition->GetMethodTable()->GetCl() != row.implementation)
            {
                ThrowInvalidManifest();
            }

            MethodDesc* pBodyMD = MemberLoader::GetMethodDescFromMethodDef(
                pModule,
                row.body,
                pWitnessMT->GetInstantiation(),
                pInterfaceMD->GetMethodInstantiation());
            if (!ValidateCanonicalBodySignature(pTargetMT, pWitnessMT, pInterfaceMT, pInterfaceMD, pBodyMD))
            {
                ThrowInvalidManifest();
            }

            if (*ppBodyMD != nullptr && *ppBodyMD != pBodyMD)
            {
                ThrowInvalidManifest();
            }

            *ppBodyMD = pBodyMD;
        });

        return *ppBodyMD != nullptr;
    }

    void ValidateWitnessMethodImplementations(
        MethodTable* pTargetMT,
        MethodTable* pWitnessMT,
        MethodTable* pDeclaredInterfaceMT)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        for (MethodTable::MethodIterator iterator(pDeclaredInterfaceMT); iterator.IsValid(); iterator.Next())
        {
            MethodDesc* pInterfaceMethod = iterator.GetMethodDesc();
            if (!pInterfaceMethod->IsVirtual())
            {
                continue;
            }

            if (pInterfaceMethod->IsStatic())
            {
                MethodDesc* pBodyMD;
                if (pInterfaceMethod->IsAbstract() &&
                    !FindCanonicalBody(
                        pTargetMT,
                        pWitnessMT,
                        pDeclaredInterfaceMT,
                        pInterfaceMethod,
                        &pBodyMD))
                {
                    ThrowInvalidManifest();
                }
                continue;
            }

            DispatchSlot slot = pWitnessMT->FindDispatchSlotForInterfaceMD(
                pInterfaceMethod,
                FALSE /* throwOnConflict */);
            if (slot.IsNull() || slot.GetMethodDesc()->IsAbstract())
            {
                ThrowInvalidManifest();
            }

            if (slot.GetMethodDesc()->GetMethodTable()->HasSameTypeDefAs(pWitnessMT))
            {
                MethodDesc* pBodyMD;
                if (!FindCanonicalBody(
                        pTargetMT,
                        pWitnessMT,
                        pDeclaredInterfaceMT,
                        pInterfaceMethod,
                        &pBodyMD))
                {
                    ThrowInvalidManifest();
                }
            }
        }
    }

    void ConsiderCandidate(
        const ManifestRow& row,
        Module* pModule,
        MethodTable* pRequestedInterfaceMT,
        MethodTable* pProjectionMT,
        UINT16 expectedFlags,
        MethodTable** ppSelectedWitnessMT,
        MethodTable** ppSelectedTargetMT,
        bool checkWitnessConstraints,
        bool detectAmbiguity)
    {
        CONTRACTL
        {
            THROWS;
            GC_TRIGGERS;
            MODE_ANY;
        }
        CONTRACTL_END;

        if (row.flags != expectedFlags)
        {
            return;
        }

        if (!detectAmbiguity && *ppSelectedWitnessMT != nullptr)
        {
            return;
        }

        TypeHandle witnessDefinition = ClassLoader::LoadTypeDefThrowing(
            pModule,
            row.implementation,
            ClassLoader::ThrowIfNotFound,
            ClassLoader::PermitUninstDefOrRef);
        if (witnessDefinition.IsTypeDesc() ||
            !witnessDefinition.IsInterface() ||
            !HasMarker(witnessDefinition.AsMethodTable()))
        {
            ThrowInvalidManifest();
        }

        TypeHandle targetRoot;
        UINT32 rootTypeVariableIndex = UINT32_MAX;
        SignatureRootKind targetRootKind = GetSignatureRoot(
            pModule,
            row.targetSignature,
            row.targetSignatureSize,
            &targetRoot,
            &rootTypeVariableIndex);
        if (expectedFlags == ExtensionInterfaceImpl_TypeOwned)
        {
            if (targetRootKind != SignatureRootKind::Nominal ||
                targetRoot.GetModule() != pModule ||
                targetRoot.GetCl() != row.owner ||
                pProjectionMT->GetModule() != pModule ||
                pProjectionMT->GetCl() != row.owner)
            {
                ThrowInvalidManifest();
            }
        }
        Instantiation formalWitnessInstantiation = witnessDefinition.GetInstantiation();
        if (targetRootKind == SignatureRootKind::TypeVariable)
        {
            if (expectedFlags != ExtensionInterfaceImpl_InterfaceOwned ||
                rootTypeVariableIndex >= formalWitnessInstantiation.GetNumArgs())
            {
                ThrowInvalidManifest();
            }

            TypeVarTypeDesc* pRootVariable = formalWitnessInstantiation[rootTypeVariableIndex].AsGenericVariable();
            if (!pRootVariable->ConstrainedAsObjRef() && !pRootVariable->ConstrainedAsValueType())
            {
                ThrowInvalidManifest();
            }

            if (!checkWitnessConstraints &&
                ((pProjectionMT->IsValueType() && !pRootVariable->ConstrainedAsValueType()) ||
                 (!pProjectionMT->IsValueType() && !pRootVariable->ConstrainedAsObjRef())))
            {
                return;
            }
        }

        StackSArray<TypeHandle> bindings;
        for (UINT32 i = 0; i < formalWitnessInstantiation.GetNumArgs(); i++)
        {
            bindings.Append(TypeHandle());
        }

        if (!MatchTarget(
                row,
                pModule,
                TypeHandle(pProjectionMT),
                bindings.GetElements(),
                bindings.GetCount()))
        {
            return;
        }

        for (COUNT_T i = 0; i < bindings.GetCount(); i++)
        {
            if (bindings[i].IsNull())
            {
                ThrowInvalidManifest();
            }
        }

        Instantiation witnessInstantiation(bindings.GetElements(), bindings.GetCount());
        if (checkWitnessConstraints && !SatisfiesWitnessConstraints(witnessDefinition, witnessInstantiation))
        {
            return;
        }

        TypeHandle witness = witnessDefinition;
        if (!witnessInstantiation.IsEmpty())
        {
            witness = ClassLoader::LoadGenericInstantiationThrowing(
                pModule,
                row.implementation,
                witnessInstantiation);
        }

        SigTypeContext signatureContext(witnessInstantiation, Instantiation());
        TypeHandle declaredInterface = SigPointer(
            row.interfaceSignature,
            row.interfaceSignatureSize).GetTypeHandleThrowing(pModule, &signatureContext);
        if (declaredInterface.IsTypeDesc() || !declaredInterface.IsInterface())
        {
            ThrowInvalidManifest();
        }

        TypeHandle interfaceRoot;
        SignatureRootKind interfaceRootKind = GetSignatureRoot(
            pModule,
            row.interfaceSignature,
            row.interfaceSignatureSize,
            &interfaceRoot);
        if (interfaceRootKind != SignatureRootKind::Nominal ||
            (expectedFlags == ExtensionInterfaceImpl_InterfaceOwned &&
             (interfaceRoot.GetModule() != pModule || interfaceRoot.GetCl() != row.owner)))
        {
            ThrowInvalidManifest();
        }

        MethodTable* pWitnessMT = witness.AsMethodTable();
        MethodTable* pDeclaredInterfaceMT = declaredInterface.AsMethodTable();
        if (!pWitnessMT->CanCastToInterface(pDeclaredInterfaceMT))
        {
            ThrowInvalidManifest();
        }

        if (expectedFlags == ExtensionInterfaceImpl_InterfaceOwned &&
            !ValidateInterfaceOwnedBaseClosure(pDeclaredInterfaceMT))
        {
            ThrowInvalidManifest();
        }

        if (pDeclaredInterfaceMT != pRequestedInterfaceMT &&
            !pDeclaredInterfaceMT->CanCastToInterface(pRequestedInterfaceMT))
        {
            return;
        }

        ValidateWitnessMethodImplementations(pProjectionMT, pWitnessMT, pDeclaredInterfaceMT);

        if (*ppSelectedWitnessMT == nullptr)
        {
            *ppSelectedWitnessMT = pWitnessMT;
            *ppSelectedTargetMT = pProjectionMT;
        }
        else if (*ppSelectedWitnessMT != pWitnessMT)
        {
            if (detectAmbiguity)
            {
                *ppSelectedWitnessMT = reinterpret_cast<MethodTable*>(static_cast<UINT_PTR>(-1));
                *ppSelectedTargetMT = nullptr;
            }
        }
        else if (*ppSelectedTargetMT != pProjectionMT)
        {
            // All rows belonging to one declaration must describe the same closed target.
            ThrowInvalidManifest();
        }
    }

    struct ResolutionKey
    {
        MethodTable* receiver;
        MethodTable* interfaceType;

        ResolutionKey(MethodTable* pReceiver = nullptr, MethodTable* pInterface = nullptr)
            : receiver(pReceiver), interfaceType(pInterface)
        {
            LIMITED_METHOD_CONTRACT;
        }
    };

    enum class ResolutionState : UINT8
    {
        NotImplemented,
        Resolved,
        Ambiguous,
    };

    struct ResolutionEntry
    {
        ResolutionKey key;
        MethodTable* witness;
        MethodTable* target;
        ResolutionState state;

        ResolutionEntry()
            : key(), witness(nullptr), target(nullptr), state(ResolutionState::NotImplemented)
        {
            LIMITED_METHOD_CONTRACT;
        }

        ResolutionEntry(
            ResolutionKey entryKey,
            MethodTable* pWitness,
            MethodTable* pTarget,
            ResolutionState entryState)
            : key(entryKey), witness(pWitness), target(pTarget), state(entryState)
        {
            LIMITED_METHOD_CONTRACT;
        }
    };

    class ResolutionCacheTraits : public NoRemoveSHashTraits<DefaultSHashTraits<ResolutionEntry>>
    {
    public:
        typedef ResolutionKey key_t;
        typedef ResolutionEntry element_t;
        typedef COUNT_T count_t;

        static key_t GetKey(const element_t& entry)
        {
            LIMITED_METHOD_CONTRACT;
            return entry.key;
        }

        static BOOL Equals(const key_t& left, const key_t& right)
        {
            LIMITED_METHOD_CONTRACT;
            return left.receiver == right.receiver && left.interfaceType == right.interfaceType;
        }

        static count_t Hash(const key_t& key)
        {
            LIMITED_METHOD_CONTRACT;
            return static_cast<count_t>(
                (reinterpret_cast<UINT_PTR>(key.receiver) >> 3) ^
                (reinterpret_cast<UINT_PTR>(key.interfaceType) >> 7));
        }

        static bool IsNull(const element_t& entry)
        {
            LIMITED_METHOD_CONTRACT;
            return entry.key.receiver == nullptr;
        }

        static const element_t Null()
        {
            LIMITED_METHOD_CONTRACT;
            return element_t();
        }
    };

    typedef SHash<ResolutionCacheTraits> ResolutionCache;
    CrstStatic s_resolutionCacheLock;
    ResolutionCache* s_pResolutionCache;

    struct ResolvingPair
    {
        MethodTable* receiver;
        MethodTable* interfaceType;
        ResolvingPair* previous;
    };

    thread_local ResolvingPair* t_pResolvingPair;

    class ResolvingPairHolder
    {
        ResolvingPair m_pair;

    public:
        ResolvingPairHolder(MethodTable* pReceiverMT, MethodTable* pInterfaceMT)
            : m_pair{pReceiverMT, pInterfaceMT, t_pResolvingPair}
        {
            LIMITED_METHOD_CONTRACT;
            t_pResolvingPair = &m_pair;
        }

        ~ResolvingPairHolder()
        {
            LIMITED_METHOD_CONTRACT;
            _ASSERTE(t_pResolvingPair == &m_pair);
            t_pResolvingPair = m_pair.previous;
        }

        bool IsOutermost() const
        {
            LIMITED_METHOD_CONTRACT;
            return m_pair.previous == nullptr;
        }
    };

    bool IsResolving(MethodTable* pReceiverMT, MethodTable* pInterfaceMT)
    {
        LIMITED_METHOD_CONTRACT;

        for (ResolvingPair* pPair = t_pResolvingPair; pPair != nullptr; pPair = pPair->previous)
        {
            if (pPair->receiver == pReceiverMT && pPair->interfaceType == pInterfaceMT)
            {
                return true;
            }
        }

        return false;
    }

    bool CanCache(MethodTable* pReceiverMT, MethodTable* pInterfaceMT)
    {
        LIMITED_METHOD_CONTRACT;
        return !TypeHandle(pReceiverMT).IsCollectible() && !TypeHandle(pInterfaceMT).IsCollectible();
    }

    bool TryGetCachedResolution(
        MethodTable* pReceiverMT,
        MethodTable* pInterfaceMT,
        ResolutionEntry* pEntry)
    {
        CONTRACTL
        {
            NOTHROW;
            GC_NOTRIGGER;
            MODE_ANY;
        }
        CONTRACTL_END;

        if (!CanCache(pReceiverMT, pInterfaceMT))
        {
            return false;
        }

        CrstHolder lock(&s_resolutionCacheLock);
        if (s_pResolutionCache == nullptr)
        {
            return false;
        }

        ResolutionEntry entry = s_pResolutionCache->Lookup(ResolutionKey(pReceiverMT, pInterfaceMT));
        if (ResolutionCacheTraits::IsNull(entry))
        {
            return false;
        }

        *pEntry = entry;
        return true;
    }

    void CacheResolution(
        MethodTable* pReceiverMT,
        MethodTable* pInterfaceMT,
        MethodTable* pWitnessMT,
        MethodTable* pTargetMT,
        ResolutionState state)
    {
        CONTRACTL
        {
            THROWS;
            GC_NOTRIGGER;
            MODE_ANY;
        }
        CONTRACTL_END;

        if (!CanCache(pReceiverMT, pInterfaceMT) ||
            (pWitnessMT != nullptr && TypeHandle(pWitnessMT).IsCollectible()) ||
            (pTargetMT != nullptr && TypeHandle(pTargetMT).IsCollectible()))
        {
            return;
        }

        CrstHolder lock(&s_resolutionCacheLock);
        if (s_pResolutionCache == nullptr)
        {
            s_pResolutionCache = new ResolutionCache();
        }

        ResolutionKey key(pReceiverMT, pInterfaceMT);
        if (ResolutionCacheTraits::IsNull(s_pResolutionCache->Lookup(key)))
        {
            s_pResolutionCache->Add(ResolutionEntry(key, pWitnessMT, pTargetMT, state));
        }
    }

    void AppendProjection(StackSArray<MethodTable*>* pProjections, MethodTable* pProjectionMT)
    {
        CONTRACTL
        {
            THROWS;
            GC_NOTRIGGER;
            MODE_ANY;
        }
        CONTRACTL_END;

        for (COUNT_T i = 0; i < pProjections->GetCount(); i++)
        {
            if ((*pProjections)[i] == pProjectionMT)
            {
                return;
            }
        }

        pProjections->Append(pProjectionMT);
    }
}

void ExtensionInterface::Initialize()
{
    WRAPPER_NO_CONTRACT;
    s_resolutionCacheLock.Init(CrstLeafLock, CRST_UNSAFE_ANYMODE);
}

void ExtensionInterface::SetMethodTableFlags(MethodTable* pMT)
{
    CONTRACTL
    {
        THROWS;
        GC_TRIGGERS;
        MODE_ANY;
    }
    CONTRACTL_END;

    bool hasTypeOwnedExtensionImpls =
        pMT->GetParentMethodTable() != nullptr && pMT->GetParentMethodTable()->HasTypeOwnedExtensionImpls();
    bool hasInterfaceOwnedExtensionImpls = false;

    MethodTable::InterfaceMapIterator interfaceIterator = pMT->IterateInterfaceMap();
    while (!hasTypeOwnedExtensionImpls && interfaceIterator.Next())
    {
        hasTypeOwnedExtensionImpls = interfaceIterator.GetInterfaceApprox()->HasTypeOwnedExtensionImpls();
    }

    Module* pModule = pMT->GetModule();
    if (pModule->HasExtensionInterfaceImplementations())
    {
        ForEachManifestRow(pModule, pMT->GetCl(), [&](const ManifestRow& row)
        {
            if (row.flags == ExtensionInterfaceImpl_TypeOwned && row.owner == pMT->GetCl())
            {
                hasTypeOwnedExtensionImpls = true;
            }
            else if (row.flags == ExtensionInterfaceImpl_InterfaceOwned && pMT->IsInterface())
            {
                hasInterfaceOwnedExtensionImpls = true;
            }
        });
    }

    if (hasTypeOwnedExtensionImpls)
    {
        pMT->SetHasTypeOwnedExtensionImpls();
    }

    if (hasInterfaceOwnedExtensionImpls)
    {
        pMT->SetHasInterfaceOwnedExtensionImpls();
    }
}

bool ExtensionInterface::IsExtensionSensitive(MethodTable* pReceiverMT, MethodTable* pInterfaceMT)
{
    LIMITED_METHOD_CONTRACT;
    return pReceiverMT->HasTypeOwnedExtensionImpls() || pInterfaceMT->HasInterfaceOwnedExtensionImpls();
}

bool ExtensionInterface::IsWitnessForReceiver(MethodTable* pReceiverMT, MethodTable* pWitnessMT)
{
    CONTRACTL
    {
        THROWS;
        GC_TRIGGERS;
        MODE_ANY;
    }
    CONTRACTL_END;

    if (!pWitnessMT->IsInterface() || !HasMarker(pWitnessMT))
    {
        return false;
    }

    MethodTable::InterfaceMapIterator interfaceIterator = pWitnessMT->IterateInterfaceMap();
    while (interfaceIterator.Next())
    {
        MethodTable* pContractMT = interfaceIterator.GetInterface(pWitnessMT);
        MethodTable* pResolvedWitnessMT;
        if (TryResolve(pReceiverMT, pContractMT, &pResolvedWitnessMT) && pResolvedWitnessMT == pWitnessMT)
        {
            return true;
        }
    }

    return false;
}

static bool TryResolveInternal(
    MethodTable* pReceiverMT,
    MethodTable* pInterfaceMT,
    MethodTable** ppWitnessMT,
    MethodTable** ppTargetMT)
{
    CONTRACTL
    {
        THROWS;
        GC_TRIGGERS;
        MODE_ANY;
        PRECONDITION(CheckPointer(pReceiverMT));
        PRECONDITION(CheckPointer(pInterfaceMT));
        PRECONDITION(pInterfaceMT->IsInterface());
        PRECONDITION(CheckPointer(ppWitnessMT));
        PRECONDITION(CheckPointer(ppTargetMT));
    }
    CONTRACTL_END;

    *ppWitnessMT = nullptr;
    *ppTargetMT = nullptr;

    if (pReceiverMT->IsNullable() ||
        pReceiverMT->IsByRefLike() ||
        !ExtensionInterface::IsExtensionSensitive(pReceiverMT, pInterfaceMT) ||
        pReceiverMT->CanCastToInterface(pInterfaceMT))
    {
        return false;
    }

    ResolutionEntry cachedEntry;
    if (TryGetCachedResolution(pReceiverMT, pInterfaceMT, &cachedEntry))
    {
        if (cachedEntry.state == ResolutionState::Ambiguous)
        {
            ThrowInvalidManifest();
        }

        *ppWitnessMT = cachedEntry.witness;
        *ppTargetMT = cachedEntry.target;
        return cachedEntry.state == ResolutionState::Resolved;
    }

    if (IsResolving(pReceiverMT, pInterfaceMT))
    {
        return false;
    }

    ResolvingPairHolder resolvingPair(pReceiverMT, pInterfaceMT);

    StackSArray<MethodTable*> projections;
    for (MethodTable* pCurrentMT = pReceiverMT; pCurrentMT != nullptr; pCurrentMT = pCurrentMT->GetParentMethodTable())
    {
        AppendProjection(&projections, pCurrentMT);
    }

    MethodTable::InterfaceMapIterator interfaceIterator = pReceiverMT->IterateInterfaceMap();
    while (interfaceIterator.Next())
    {
        AppendProjection(&projections, interfaceIterator.GetInterface(pReceiverMT));
    }

    MethodTable* pSelectedWitnessMT = nullptr;
    MethodTable* pSelectedTargetMT = nullptr;
    for (COUNT_T i = 0; i < projections.GetCount(); i++)
    {
        MethodTable* pProjectionMT = projections[i];
        Module* pProjectionModule = pProjectionMT->GetModule();
        if (!pProjectionModule->HasExtensionInterfaceImplementations())
        {
            continue;
        }

        ForEachManifestRow(pProjectionModule, pProjectionMT->GetCl(), [&](const ManifestRow& row)
        {
            if (row.owner == pProjectionMT->GetCl())
            {
                ConsiderCandidate(
                    row,
                    pProjectionModule,
                    pInterfaceMT,
                    pProjectionMT,
                    ExtensionInterfaceImpl_TypeOwned,
                    &pSelectedWitnessMT,
                    &pSelectedTargetMT,
                    true,
                    true);
            }
        });
    }

    Module* pInterfaceModule = pInterfaceMT->GetModule();
    if (pInterfaceModule->HasExtensionInterfaceImplementations())
    {
        ForEachManifestRow(pInterfaceModule, pInterfaceMT->GetCl(), [&](const ManifestRow& row)
        {
            if (row.flags != ExtensionInterfaceImpl_InterfaceOwned)
            {
                return;
            }

            TypeHandle targetRoot;
            SignatureRootKind rootKind = GetSignatureRoot(
                pInterfaceModule,
                row.targetSignature,
                row.targetSignatureSize,
                &targetRoot);

            // A target rooted in a type variable denotes the exact receiver, not
            // each of its nominal projections.
            if (rootKind == SignatureRootKind::TypeVariable)
            {
                ConsiderCandidate(
                    row,
                    pInterfaceModule,
                    pInterfaceMT,
                    pReceiverMT,
                    ExtensionInterfaceImpl_InterfaceOwned,
                    &pSelectedWitnessMT,
                    &pSelectedTargetMT,
                    true,
                    true);
                return;
            }

            for (COUNT_T i = 0; i < projections.GetCount(); i++)
            {
                ConsiderCandidate(
                    row,
                    pInterfaceModule,
                    pInterfaceMT,
                    projections[i],
                    ExtensionInterfaceImpl_InterfaceOwned,
                    &pSelectedWitnessMT,
                    &pSelectedTargetMT,
                    true,
                    true);
            }
        });
    }

    MethodTable* const ambiguous = reinterpret_cast<MethodTable*>(static_cast<UINT_PTR>(-1));
    if (pSelectedWitnessMT == ambiguous)
    {
        CacheResolution(pReceiverMT, pInterfaceMT, nullptr, nullptr, ResolutionState::Ambiguous);
        ThrowInvalidManifest();
    }

    if (pSelectedWitnessMT == nullptr)
    {
        if (resolvingPair.IsOutermost())
        {
            CacheResolution(pReceiverMT, pInterfaceMT, nullptr, nullptr, ResolutionState::NotImplemented);
        }
        return false;
    }

    CacheResolution(
        pReceiverMT,
        pInterfaceMT,
        pSelectedWitnessMT,
        pSelectedTargetMT,
        ResolutionState::Resolved);
    *ppWitnessMT = pSelectedWitnessMT;
    *ppTargetMT = pSelectedTargetMT;
    return true;
}

static bool TryResolveApproximateInternal(
    MethodTable* pReceiverMT,
    MethodTable* pInterfaceMT,
    MethodTable** ppWitnessMT,
    MethodTable** ppTargetMT)
{
    CONTRACTL
    {
        THROWS;
        GC_TRIGGERS;
        MODE_ANY;
    }
    CONTRACTL_END;

    *ppWitnessMT = nullptr;
    *ppTargetMT = nullptr;
    if (pReceiverMT->IsNullable() ||
        pReceiverMT->IsByRefLike() ||
        !pReceiverMT->IsSharedByGenericInstantiations() ||
        !ExtensionInterface::IsExtensionSensitive(pReceiverMT, pInterfaceMT) ||
        pReceiverMT->CanCastToInterface(pInterfaceMT))
    {
        return false;
    }

    StackSArray<MethodTable*> projections;
    for (MethodTable* pCurrentMT = pReceiverMT; pCurrentMT != nullptr; pCurrentMT = pCurrentMT->GetParentMethodTable())
    {
        AppendProjection(&projections, pCurrentMT);
    }

    MethodTable::InterfaceMapIterator interfaceIterator = pReceiverMT->IterateInterfaceMap();
    while (interfaceIterator.Next())
    {
        AppendProjection(&projections, interfaceIterator.GetInterface(pReceiverMT));
    }

    for (COUNT_T i = 0; i < projections.GetCount(); i++)
    {
        MethodTable* pProjectionMT = projections[i];
        Module* pProjectionModule = pProjectionMT->GetModule();
        if (!pProjectionModule->HasExtensionInterfaceImplementations())
        {
            continue;
        }

        ForEachManifestRow(pProjectionModule, pProjectionMT->GetCl(), [&](const ManifestRow& row)
        {
            if (row.owner == pProjectionMT->GetCl())
            {
                ConsiderCandidate(
                    row,
                    pProjectionModule,
                    pInterfaceMT,
                    pProjectionMT,
                    ExtensionInterfaceImpl_TypeOwned,
                    ppWitnessMT,
                    ppTargetMT,
                    false,
                    false);
            }
        });
    }

    Module* pInterfaceModule = pInterfaceMT->GetModule();
    if (pInterfaceModule->HasExtensionInterfaceImplementations())
    {
        ForEachManifestRow(pInterfaceModule, pInterfaceMT->GetCl(), [&](const ManifestRow& row)
        {
            if (row.flags != ExtensionInterfaceImpl_InterfaceOwned)
            {
                return;
            }

            TypeHandle targetRoot;
            SignatureRootKind rootKind = GetSignatureRoot(
                pInterfaceModule,
                row.targetSignature,
                row.targetSignatureSize,
                &targetRoot);
            if (rootKind == SignatureRootKind::TypeVariable)
            {
                ConsiderCandidate(
                    row,
                    pInterfaceModule,
                    pInterfaceMT,
                    pReceiverMT,
                    ExtensionInterfaceImpl_InterfaceOwned,
                    ppWitnessMT,
                    ppTargetMT,
                    false,
                    false);
                return;
            }

            for (COUNT_T i = 0; i < projections.GetCount(); i++)
            {
                ConsiderCandidate(
                    row,
                    pInterfaceModule,
                    pInterfaceMT,
                    projections[i],
                    ExtensionInterfaceImpl_InterfaceOwned,
                    ppWitnessMT,
                    ppTargetMT,
                    false,
                    false);
            }
        });
    }

    return *ppWitnessMT != nullptr;
}

bool ExtensionInterface::TryResolve(
    MethodTable* pReceiverMT,
    MethodTable* pInterfaceMT,
    MethodTable** ppWitnessMT)
{
    WRAPPER_NO_CONTRACT;

    MethodTable* pTargetMT;
    return TryResolveInternal(pReceiverMT, pInterfaceMT, ppWitnessMT, &pTargetMT);
}

bool ExtensionInterface::TryResolveCanonicalBody(
    MethodTable* pReceiverMT,
    MethodTable* pInterfaceMT,
    MethodDesc* pInterfaceMD,
    MethodDesc** ppBodyMD)
{
    CONTRACTL
    {
        THROWS;
        GC_TRIGGERS;
        MODE_ANY;
        PRECONDITION(CheckPointer(pReceiverMT));
        PRECONDITION(CheckPointer(pInterfaceMT));
        PRECONDITION(pInterfaceMT->IsInterface());
        PRECONDITION(CheckPointer(pInterfaceMD));
        PRECONDITION(CheckPointer(ppBodyMD));
    }
    CONTRACTL_END;

    *ppBodyMD = nullptr;

    MethodTable* pWitnessMT;
    MethodTable* pTargetMT;
    if (!TryResolveInternal(
            pReceiverMT,
            pInterfaceMT,
            &pWitnessMT,
            &pTargetMT))
    {
        return false;
    }

    // A constrained value receiver can be forwarded without boxing only when
    // the declaration target is that exact value type. A declaration selected
    // through a reference-type nominal projection continues through the boxed
    // witness adapter instead.
    if (!pInterfaceMD->IsStatic() && pReceiverMT->IsValueType() && pTargetMT != pReceiverMT)
    {
        return false;
    }

    if (FindCanonicalBody(
        pTargetMT,
        pWitnessMT,
        pInterfaceMT,
        pInterfaceMD,
        ppBodyMD))
    {
        return true;
    }

    if (pInterfaceMD->IsStatic() && !pInterfaceMD->IsAbstract())
    {
        GCX_PREEMP();
        *ppBodyMD = MethodDesc::FindOrCreateAssociatedMethodDesc(
            pInterfaceMD->StripMethodInstantiation(),
            pInterfaceMT,
            FALSE,
            pInterfaceMD->GetMethodInstantiation(),
            FALSE);
        return true;
    }

    return false;
}

bool ExtensionInterface::TryResolveCanonicalBodyApprox(
    MethodTable* pReceiverMT,
    MethodTable* pInterfaceMT,
    MethodDesc* pInterfaceMD,
    MethodDesc** ppBodyMD)
{
    CONTRACTL
    {
        THROWS;
        GC_TRIGGERS;
        MODE_ANY;
        PRECONDITION(CheckPointer(pReceiverMT));
        PRECONDITION(CheckPointer(pInterfaceMT));
        PRECONDITION(pInterfaceMT->IsInterface());
        PRECONDITION(CheckPointer(pInterfaceMD));
        PRECONDITION(CheckPointer(ppBodyMD));
    }
    CONTRACTL_END;

    *ppBodyMD = nullptr;

    MethodTable* pWitnessMT;
    MethodTable* pTargetMT;
    if (!TryResolveApproximateInternal(
            pReceiverMT,
            pInterfaceMT,
            &pWitnessMT,
            &pTargetMT) ||
        (!pInterfaceMD->IsStatic() && pReceiverMT->IsValueType() && pTargetMT != pReceiverMT))
    {
        return false;
    }

    if (FindCanonicalBody(
            pTargetMT,
            pWitnessMT,
            pInterfaceMT,
            pInterfaceMD,
            ppBodyMD))
    {
        return true;
    }

    if (pInterfaceMD->IsStatic() && !pInterfaceMD->IsAbstract())
    {
        GCX_PREEMP();
        *ppBodyMD = MethodDesc::FindOrCreateAssociatedMethodDesc(
            pInterfaceMD->StripMethodInstantiation(),
            pInterfaceMT,
            FALSE,
            pInterfaceMD->GetMethodInstantiation(),
            FALSE);
        return true;
    }

    return false;
}
