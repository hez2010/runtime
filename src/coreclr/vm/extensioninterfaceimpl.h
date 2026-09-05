// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#ifndef _EXTENSIONINTERFACEIMPL_H_
#define _EXTENSIONINTERFACEIMPL_H_

class MethodTable;
class MethodDesc;
class TypeHandle;

namespace ExtensionInterface
{
    void Initialize();

    // Set immutable participation flags while a MethodTable is being built.
    void SetMethodTableFlags(MethodTable* pMT);

    bool IsExtensionSensitive(MethodTable* pReceiverMT, MethodTable* pInterfaceMT);
    bool IsWitnessForReceiver(MethodTable* pReceiverMT, MethodTable* pWitnessMT);

    // Returns the closed witness interface for an extension implementation. Nominal
    // implementations are deliberately not returned by this operation.
    bool TryResolve(MethodTable* pReceiverMT, MethodTable* pInterfaceMT, MethodTable** ppWitnessMT);

    // Constraint validation may prove a constructed open pair in its generic
    // parameter context. Such proofs never enter the exact runtime pair cache.
    bool SatisfiesConstraint(MethodTable* pReceiverMT, MethodTable* pInterfaceMT);

    // A proved implementation may discharge a self-reference while validating
    // its contract type. This is not an assumption for witness applicability.
    bool IsContractValidationAssumption(
        MethodTable* pValidatingInterfaceMT, TypeHandle receiver, MethodTable* pConstraintMT);

    // Returns the canonical static body associated with an interface member. The
    // body has an explicit receiver argument for instance interface members. The
    // result is an ordinary instantiation of a MethodDef on the open witness;
    // resolving a receiver/interface pair never creates or clones an IL body.
    bool TryResolveCanonicalBody(
        MethodTable* pReceiverMT,
        MethodTable* pInterfaceMT,
        MethodDesc* pInterfaceMD,
        MethodDesc** ppBodyMD);

    // Returns an ABI-compatible canonical body for shared generic code. This
    // ignores witness constraints because the exact dictionary instantiation
    // validates and resolves the pair before publishing its entry point.
    bool TryResolveCanonicalBodyApprox(
        MethodTable* pReceiverMT,
        MethodTable* pInterfaceMT,
        MethodDesc* pInterfaceMD,
        MethodDesc** ppBodyMD);
}

#endif // _EXTENSIONINTERFACEIMPL_H_
