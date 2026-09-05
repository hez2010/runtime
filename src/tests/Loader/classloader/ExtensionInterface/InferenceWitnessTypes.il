// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly extern System.Collections { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly InferenceWitnessTypes { }
.module InferenceWitnessTypes.dll

// Prototype manifest tokens refer to the definitions below; keep declaration order.

// IInferred`1 -> ContractInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 09 00 00 02 0A 00 00 02 02 00 00 00 13 00 06 00 00 00 15 12 24 01 13 01 02 00 00 00
)

// IListInference -> ListInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 0B 00 00 02 0C 00 00 02 02 00 00 00 13 01 02 00 00 00 12 2C 02 00 00 00
)

// IElementInference -> ElementInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 0D 00 00 02 0E 00 00 02 02 00 00 00 13 01 02 00 00 00 12 34 02 00 00 00
)

// ISelectedInference -> SelectedInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 0F 00 00 02 10 00 00 02 02 00 00 00 13 01 02 00 00 00 12 3C 02 00 00 00
)

// IRepeatedInference -> RepeatedInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 11 00 00 02 12 00 00 02 02 00 00 00 13 01 02 00 00 00 12 44 02 00 00 00
)

// ICovariantInference`1 -> CovariantInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 13 00 00 02 14 00 00 02 02 00 00 00 13 01 06 00 00 00 15 12 4C 01 13 00 02 00 00 00
)

// IChainedInference -> ChainedInferenceWitness`3
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 15 00 00 02 16 00 00 02 02 00 00 00 13 02 02 00 00 00 12 54 02 00 00 00
)

// IContractChainInference`1 -> ContractChainInferenceWitness`3
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 17 00 00 02 18 00 00 02 02 00 00 00 13 00 06 00 00 00 15 12 5C 01 13 01 02 00 00 00
)

// IUnseededInference -> UnseededInferenceWitness`3
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 19 00 00 02 1A 00 00 02 02 00 00 00 13 00 02 00 00 00 12 64 02 00 00 00
)

// ISeededInference`1 -> SeededInferenceWitness`3
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 1B 00 00 02 1C 00 00 02 02 00 00 00 13 00 06 00 00 00 15 12 6C 01 13 01 02 00 00 00
)

// InferenceContext`1 -> MixedInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 1E 00 00 02 1F 00 00 02 06 00 00 00 15 12 78 01 13 00 08 00 00 00 15 12 74 02 13 00 13 01 01 00 00 00
)

// ICovariantValueInference`1 -> CovariantClassValueWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 21 00 00 02 22 00 00 02 02 00 00 00 13 01 07 00 00 00 15 12 80 84 01 13 00 02 00 00 00
)

// ICovariantValueInference`1 -> CovariantStructValueWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 21 00 00 02 23 00 00 02 02 00 00 00 13 01 07 00 00 00 15 12 80 84 01 13 00 02 00 00 00
)

// InferredValueTarget -> ValueInferenceWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 25 00 00 02 26 00 00 02 03 00 00 00 11 80 94 07 00 00 00 15 12 80 90 01 13 00 01 00 00 00
)

// InferenceListBox`1 -> BoxInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 28 00 00 02 29 00 00 02 07 00 00 00 15 11 80 A0 01 13 01 03 00 00 00 12 80 9C 01 00 00 00
)

// IInferenceChild`1 -> InheritedInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 2B 00 00 02 2C 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 80 AC 01 13 01 02 00 00 00
)

// IInferenceLeft`1 -> MultiContractInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 2D 00 00 02 2F 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 80 B4 01 13 01 02 00 00 00
)

// IInferenceRight`1 -> MultiContractInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 2E 00 00 02 2F 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 80 B8 01 13 01 02 00 00 00
)

// IInferenceTagged`1 -> ErasedInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 31 00 00 02 32 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 80 C4 01 13 01 02 00 00 00
)

// IVariantOnlyInference`1 -> VariantOnlyInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 33 00 00 02 34 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 80 CC 01 13 01 02 00 00 00
)

// IInferenceElement`1 -> ExtensionElementWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 05 00 00 02 35 00 00 02 02 00 00 00 13 00 05 00 00 00 15 12 14 01 08 02 00 00 00
)

// IExtensionConstraintInference`1 -> ExtensionConstraintInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 36 00 00 02 37 00 00 02 02 00 00 00 13 01 07 00 00 00 15 12 80 D8 01 13 00 02 00 00 00
)

// IStaticInference`1 -> StaticInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 38 00 00 02 39 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 80 E0 01 13 01 02 00 00 00
)

// IRecursiveInference -> RecursiveInferenceWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 3A 00 00 02 3D 00 00 02 02 00 00 00 13 01 03 00 00 00 12 80 E8 02 00 00 00
)

// InferenceProofTarget`1 -> InferenceProofWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 3C 00 00 02 3E 00 00 02 07 00 00 00 15 12 80 F0 01 13 00 03 00 00 00 12 80 EC 01 00 00 00
)

// IInferred`1.Echo -> ContractInferenceWitness`2.EchoBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0A 00 00 02 04 00 00 06 08 00 00 06 00 00
)

// IInferred`1.EchoMethod -> ContractInferenceWitness`2.EchoMethodBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0A 00 00 02 05 00 00 06 0A 00 00 06 00 00
)

// IInferred`1.EchoConstrained -> ContractInferenceWitness`2.EchoConstrainedBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0A 00 00 02 06 00 00 06 0C 00 00 06 00 00
)

// IListInference.GetElementType -> ListInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0C 00 00 02 0D 00 00 06 0F 00 00 06 00 00
)

// IElementInference.GetElementType -> ElementInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0E 00 00 02 10 00 00 06 12 00 00 06 00 00
)

// ISelectedInference.GetElementType -> SelectedInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 10 00 00 02 13 00 00 06 15 00 00 06 00 00
)

// IRepeatedInference.GetElementType -> RepeatedInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 12 00 00 02 16 00 00 06 18 00 00 06 00 00
)

// ICovariantInference`1.GetElementType -> CovariantInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 14 00 00 02 19 00 00 06 1B 00 00 06 00 00
)

// IChainedInference.GetElementType -> ChainedInferenceWitness`3.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 16 00 00 02 1C 00 00 06 1E 00 00 06 00 00
)

// IContractChainInference`1.GetElementType -> ContractChainInferenceWitness`3.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 18 00 00 02 1F 00 00 06 21 00 00 06 00 00
)

// ISeededInference`1.GetElementType -> SeededInferenceWitness`3.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 1C 00 00 02 22 00 00 06 24 00 00 06 00 00
)

// IMixedInference`2.GetElementType -> MixedInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 1F 00 00 02 25 00 00 06 28 00 00 06 00 00
)

// ICovariantValueInference`1.GetValue -> CovariantClassValueWitness`2.GetValueBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 22 00 00 02 2A 00 00 06 2C 00 00 06 00 00
)

// ICovariantValueInference`1.GetValue -> CovariantStructValueWitness`2.GetValueBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 23 00 00 02 2A 00 00 06 2E 00 00 06 00 00
)

// IValueInference`1.GetElementType -> ValueInferenceWitness`1.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 26 00 00 02 2F 00 00 06 32 00 00 06 00 00
)

// IValueInference`1.Increment -> ValueInferenceWitness`1.IncrementBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 26 00 00 02 30 00 00 06 34 00 00 06 00 00
)

// IBoxInference.GetElementType -> BoxInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 29 00 00 02 35 00 00 06 38 00 00 06 00 00
)

// IBoxInference.Increment -> BoxInferenceWitness`2.IncrementBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 29 00 00 02 36 00 00 06 3A 00 00 06 00 00
)

// IInferenceBase`1.GetElementType -> InheritedInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 2C 00 00 02 3B 00 00 06 3E 00 00 06 00 00
)

// IInferenceChild`1.GetChildElementType -> InheritedInferenceWitness`2.GetElementTypeBodyChild
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 2C 00 00 02 3C 00 00 06 40 00 00 06 00 00
)

// IInferenceLeft`1.GetElementType -> MultiContractInferenceWitness`2.GetElementTypeBodyLeft
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 2F 00 00 02 41 00 00 06 44 00 00 06 00 00
)

// IInferenceRight`1.GetElementType -> MultiContractInferenceWitness`2.GetElementTypeBodyRight
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 2F 00 00 02 42 00 00 06 46 00 00 06 00 00
)

// IInferenceErased.GetElementType -> ErasedInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 32 00 00 02 47 00 00 06 49 00 00 06 00 00
)

// IVariantOnlyInference`1.GetElementType -> VariantOnlyInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 34 00 00 02 4A 00 00 06 4C 00 00 06 00 00
)

// IExtensionConstraintInference`1.GetElementType -> ExtensionConstraintInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 37 00 00 02 4D 00 00 06 4F 00 00 06 00 00
)

// IStaticInference`1.GetElementType -> StaticInferenceWitness`2.GetElementTypeBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 39 00 00 02 50 00 00 06 51 00 00 06 00 00
)

.class private auto ansi sealed System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute extends [System.Runtime]System.Attribute
{
    .method public specialname rtspecialname instance void .ctor(int32, int32, uint8[], uint8[], uint16) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Attribute::.ctor()
        ret
    }

}

.class private auto ansi sealed System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute extends [System.Runtime]System.Attribute
{
    .method public specialname rtspecialname instance void .ctor(int32, int32, int32) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Attribute::.ctor()
        ret
    }

}

.class interface public abstract auto ansi IInferenceReceiver
{
}

.class interface public abstract auto ansi IInferenceElement`1<T>
{
}

.class interface public abstract auto ansi IInferenceSelect`1<T>
{
}

.class interface public abstract auto ansi IInferencePair`2<TFirst, TSecond>
{
}

.class public sealed auto ansi InferredMethodArgument extends [System.Runtime]System.Object implements IInferenceReceiver
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi IInferred`1<T>
{
    .method public hidebysig newslot abstract virtual instance !T Echo(!T) cil managed
    {
    }

    .method public hidebysig newslot abstract virtual instance !!U[] EchoMethod<U>(!T, !!U[]) cil managed
    {
    }

    .method public hidebysig newslot abstract virtual instance !!U EchoConstrained<(class IInferenceElement`1<int32>) U>(!!U) cil managed
    {
    }

}

.class interface private abstract auto ansi ContractInferenceWitness`2<class (IInferenceReceiver) TReceiver, TElement> implements class IInferred`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance !TElement Echo(!TElement) cil managed
    {
        .override method instance !0 class IInferred`1<!TElement>::Echo(!0)
        ldarg.0
        castclass !TReceiver
        ldarg.1
        call !TElement class ContractInferenceWitness`2<!TReceiver, !TElement>::EchoBody(!TReceiver, !TElement)
        ret
    }

    .method private hidebysig static !TElement EchoBody(!TReceiver, !TElement) cil managed
    {
        ldarg.1
        ret
    }

    .method private final hidebysig newslot virtual instance !!U[] EchoMethod<U>(!TElement, !!U[]) cil managed
    {
        .override method instance !!0[] class IInferred`1<!TElement>::EchoMethod<[1]>(!0, !!0[])
        ldarg.0
        castclass !TReceiver
        ldarg.1
        ldarg.2
        call !!U[] class ContractInferenceWitness`2<!TReceiver, !TElement>::EchoMethodBody<!!U>(!TReceiver, !TElement, !!U[])
        ret
    }

    .method private hidebysig static !!U[] EchoMethodBody<U>(!TReceiver, !TElement, !!U[]) cil managed
    {
        ldarg.2
        ret
    }

    .method private final hidebysig newslot virtual instance !!U EchoConstrained<(class IInferenceElement`1<int32>) U>(!!U) cil managed
    {
        .override method instance !!0 class IInferred`1<!TElement>::EchoConstrained<[1]>(!!0)
        ldarg.0
        castclass !TReceiver
        ldarg.1
        call !!U class ContractInferenceWitness`2<!TReceiver, !TElement>::EchoConstrainedBody<!!U>(!TReceiver, !!U)
        ret
    }

    .method private hidebysig static !!U EchoConstrainedBody<(class IInferenceElement`1<int32>) U>(!TReceiver, !!U) cil managed
    {
        ldarg.1
        ret
    }

}

.class interface public abstract auto ansi IListInference
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi ListInferenceWitness`2<TElement, class (class [System.Runtime]System.Collections.Generic.IList`1<!TElement>) TReceiver> implements IListInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override IListInference::GetElementType
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class ListInferenceWitness`2<!TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IElementInference
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi ElementInferenceWitness`2<TElement, class (class IInferenceElement`1<!TElement>) TReceiver> implements IElementInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override IElementInference::GetElementType
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class ElementInferenceWitness`2<!TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi ISelectedInference
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi SelectedInferenceWitness`2<TElement, class (class IInferenceElement`1<!TElement>, class IInferenceSelect`1<!TElement>) TReceiver> implements ISelectedInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override ISelectedInference::GetElementType
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class SelectedInferenceWitness`2<!TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IRepeatedInference
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi RepeatedInferenceWitness`2<TElement, class (class IInferencePair`2<!TElement, !TElement>) TReceiver> implements IRepeatedInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override IRepeatedInference::GetElementType
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class RepeatedInferenceWitness`2<!TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi ICovariantInference`1<+T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi CovariantInferenceWitness`2<TElement, class (class IInferenceElement`1<!TElement>) TReceiver> implements class ICovariantInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class ICovariantInference`1<!TElement>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class CovariantInferenceWitness`2<!TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IChainedInference
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi ChainedInferenceWitness`3<class (class IInferenceElement`1<!TElement>) TMiddle, TElement, class (class IInferenceElement`1<!TMiddle>) TReceiver> implements IChainedInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override IChainedInference::GetElementType
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class ChainedInferenceWitness`3<!TMiddle, !TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IContractChainInference`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi ContractChainInferenceWitness`3<class (IInferenceReceiver) TReceiver, class (class IInferenceElement`1<!TElement>) TMiddle, TElement> implements class IContractChainInference`1<!TMiddle>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IContractChainInference`1<!TMiddle>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class ContractChainInferenceWitness`3<!TReceiver, !TMiddle, !TElement>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IUnseededInference
{
}

.class interface private abstract auto ansi UnseededInferenceWitness`3<class (IInferenceReceiver) TReceiver, (class IInferenceElement`1<!TSecond>) TFirst, (class IInferenceElement`1<!TFirst>) TSecond> implements IUnseededInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

}

.class interface public abstract auto ansi ISeededInference`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi SeededInferenceWitness`3<class (IInferenceReceiver) TReceiver, (class IInferenceElement`1<!TElement>) TFirst, (class IInferenceElement`1<!TFirst>) TElement> implements class ISeededInference`1<!TFirst>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class ISeededInference`1<!TFirst>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class SeededInferenceWitness`3<!TReceiver, !TFirst, !TElement>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IMixedInference`2<-TContext, TElement>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class public auto ansi InferenceContext`1<TContext> extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface private abstract auto ansi MixedInferenceWitness`2<TContext, TElement> implements class IMixedInference`2<!TContext, !TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IMixedInference`2<!TContext, !TElement>::GetElementType()
        ldarg.0
        castclass class InferenceContext`1<!TContext>
        call class [System.Runtime]System.Type class MixedInferenceWitness`2<!TContext, !TElement>::GetElementTypeBody(class InferenceContext`1<!TContext>)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(class InferenceContext`1<!TContext>) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IInferenceValue`1<+T>
{
    .method public hidebysig newslot abstract virtual instance !T GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi ICovariantValueInference`1<+T>
{
    .method public hidebysig newslot abstract virtual instance !T GetValue() cil managed
    {
    }

}

.class interface private abstract auto ansi CovariantClassValueWitness`2<TElement, class (class IInferenceValue`1<!TElement>) TReceiver> implements class ICovariantValueInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance !TElement GetValue() cil managed
    {
        .override method instance !0 class ICovariantValueInference`1<!TElement>::GetValue()
        ldarg.0
        castclass !TReceiver
        call !TElement class CovariantClassValueWitness`2<!TElement, !TReceiver>::GetValueBody(!TReceiver)
        ret
    }

    .method private hidebysig static !TElement GetValueBody(!TReceiver) cil managed
    {
        ldarga.s 0
        constrained. !TReceiver
        callvirt instance !0 class IInferenceValue`1<!TElement>::GetValue()
        ret
    }

}

.class interface private abstract auto ansi CovariantStructValueWitness`2<TElement, valuetype .ctor ([System.Runtime]System.ValueType, class IInferenceValue`1<!TElement>) TReceiver> implements class ICovariantValueInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance !TElement GetValue() cil managed
    {
        .override method instance !0 class ICovariantValueInference`1<!TElement>::GetValue()
        ldarg.0
        unbox !TReceiver
        call !TElement class CovariantStructValueWitness`2<!TElement, !TReceiver>::GetValueBody(!TReceiver&)
        ret
    }

    .method private hidebysig static !TElement GetValueBody(!TReceiver&) cil managed
    {
        ldarg.0
        constrained. !TReceiver
        callvirt instance !0 class IInferenceValue`1<!TElement>::GetValue()
        ret
    }

}

.class interface public abstract auto ansi IValueInference`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

    .method public hidebysig newslot abstract virtual instance int32 Increment() cil managed
    {
    }

}

.class public sequential ansi sealed beforefieldinit InferredValueTarget extends [System.Runtime]System.ValueType
{
    .field public int32 Value
}

.class interface private abstract auto ansi ValueInferenceWitness`1<TElement> implements class IValueInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IValueInference`1<!TElement>::GetElementType()
        ldarg.0
        unbox valuetype InferredValueTarget
        call class [System.Runtime]System.Type class ValueInferenceWitness`1<!TElement>::GetElementTypeBody(valuetype InferredValueTarget&)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(valuetype InferredValueTarget&) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private final hidebysig newslot virtual instance int32 Increment() cil managed
    {
        .override method instance int32 class IValueInference`1<!TElement>::Increment()
        ldarg.0
        unbox InferredValueTarget
        call int32 class ValueInferenceWitness`1<!TElement>::IncrementBody(valuetype InferredValueTarget&)
        ret
    }

    .method private hidebysig static int32 IncrementBody(valuetype InferredValueTarget&) cil managed
    {
        ldarg.0
        dup
        ldfld int32 InferredValueTarget::Value
        ldc.i4.1
        add
        stfld int32 InferredValueTarget::Value
        ldarg.0
        ldfld int32 InferredValueTarget::Value
        ret
    }

}

.class interface public abstract auto ansi IBoxInference
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

    .method public hidebysig newslot abstract virtual instance int32 Increment() cil managed
    {
    }

}

.class public sequential ansi sealed beforefieldinit InferenceListBox`1<class TList> extends [System.Runtime]System.ValueType
{
    .field public !TList List
    .field public int32 Version
}

.class interface private abstract auto ansi BoxInferenceWitness`2<TElement, class (class [System.Runtime]System.Collections.Generic.IList`1<!TElement>) TList> implements IBoxInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override IBoxInference::GetElementType
        ldarg.0
        unbox valuetype InferenceListBox`1<!TList>
        call class [System.Runtime]System.Type class BoxInferenceWitness`2<!TElement, !TList>::GetElementTypeBody(valuetype InferenceListBox`1<!TList>&)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(valuetype InferenceListBox`1<!TList>&) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private final hidebysig newslot virtual instance int32 Increment() cil managed
    {
        .override IBoxInference::Increment
        ldarg.0
        unbox valuetype InferenceListBox`1<!TList>
        call int32 class BoxInferenceWitness`2<!TElement, !TList>::IncrementBody(valuetype InferenceListBox`1<!TList>&)
        ret
    }

    .method private hidebysig static int32 IncrementBody(valuetype InferenceListBox`1<!TList>&) cil managed
    {
        ldarg.0
        dup
        ldfld int32 valuetype InferenceListBox`1<!TList>::Version
        ldc.i4.1
        add
        stfld int32 valuetype InferenceListBox`1<!TList>::Version
        ldarg.0
        ldfld int32 valuetype InferenceListBox`1<!TList>::Version
        ret
    }

}

.class interface public abstract auto ansi IInferenceBase`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface public abstract auto ansi IInferenceChild`1<T> implements class IInferenceBase`1<class [System.Collections]System.Collections.Generic.List`1<!T>>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetChildElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi InheritedInferenceWitness`2<class (IInferenceReceiver) TReceiver, TElement> implements class IInferenceChild`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IInferenceBase`1<class [System.Collections]System.Collections.Generic.List`1<!TElement>>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class InheritedInferenceWitness`2<!TReceiver, !TElement>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementTypeChild() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IInferenceChild`1<!TElement>::GetChildElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class InheritedInferenceWitness`2<!TReceiver, !TElement>::GetElementTypeBodyChild(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBodyChild(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IInferenceLeft`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface public abstract auto ansi IInferenceRight`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi MultiContractInferenceWitness`2<class (IInferenceReceiver) TReceiver, TElement> implements class IInferenceLeft`1<!TElement>, class IInferenceRight`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementTypeLeft() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IInferenceLeft`1<!TElement>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class MultiContractInferenceWitness`2<!TReceiver, !TElement>::GetElementTypeBodyLeft(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBodyLeft(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementTypeRight() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IInferenceRight`1<!TElement>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class MultiContractInferenceWitness`2<!TReceiver, !TElement>::GetElementTypeBodyRight(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBodyRight(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IInferenceErased
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface public abstract auto ansi IInferenceTagged`1<T> implements IInferenceErased
{
}

.class interface private abstract auto ansi ErasedInferenceWitness`2<class (IInferenceReceiver) TReceiver, TElement> implements class IInferenceTagged`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override IInferenceErased::GetElementType
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class ErasedInferenceWitness`2<!TReceiver, !TElement>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IVariantOnlyInference`1<+T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi VariantOnlyInferenceWitness`2<class (IInferenceReceiver) TReceiver, TElement> implements class IVariantOnlyInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IVariantOnlyInference`1<!TElement>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class VariantOnlyInferenceWitness`2<!TReceiver, !TElement>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface private abstract auto ansi ExtensionElementWitness`1<class (IInferenceReceiver) TReceiver> implements class IInferenceElement`1<int32>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

}

.class interface public abstract auto ansi IExtensionConstraintInference`1<T>
{
    .method public hidebysig newslot abstract virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi ExtensionConstraintInferenceWitness`2<TElement, class (class IInferenceElement`1<!TElement>) TReceiver> implements class IExtensionConstraintInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance class [System.Runtime]System.Type GetElementType() cil managed
    {
        .override method instance class [System.Runtime]System.Type class IExtensionConstraintInference`1<!TElement>::GetElementType()
        ldarg.0
        castclass !TReceiver
        call class [System.Runtime]System.Type class ExtensionConstraintInferenceWitness`2<!TElement, !TReceiver>::GetElementTypeBody(!TReceiver)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody(!TReceiver) cil managed
    {
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IStaticInference`1<T>
{
    .method public hidebysig newslot abstract virtual static class [System.Runtime]System.Type GetElementType() cil managed
    {
    }

}

.class interface private abstract auto ansi StaticInferenceWitness`2<class (IInferenceReceiver) TReceiver, TElement> implements class IStaticInference`1<!TElement>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private hidebysig static class [System.Runtime]System.Type GetElementTypeBody() cil managed
    {
        .override method class [System.Runtime]System.Type class IStaticInference`1<!TElement>::GetElementType()
        ldtoken !TElement
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

}

.class interface public abstract auto ansi IRecursiveInference
{
}

.class interface public abstract auto ansi IInferenceProof
{
}

.class public auto ansi InferenceProofTarget`1<T> extends [System.Runtime]System.Object
{
}

.class interface private abstract auto ansi RecursiveInferenceWitness`2<(IInferenceProof) TElement, class (class IInferenceElement`1<!TElement>) TReceiver> implements IRecursiveInference
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

}

.class interface private abstract auto ansi InferenceProofWitness`1<(IRecursiveInference) TReceiver> implements IInferenceProof
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

}

.class public abstract sealed auto ansi InferenceCalls extends [System.Runtime]System.Object
{
    .method public hidebysig static class InferredMethodArgument ContractConstrained<T>(object, class InferredMethodArgument) cil managed noinlining
    {
        ldarg.0
        castclass class IInferred`1<!!T>
        ldarg.1
        callvirt instance !!0 class IInferred`1<!!T>::EchoConstrained<class InferredMethodArgument>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type StaticElement<class TReceiver, TElement>() cil managed noinlining
    {
        constrained. !!TReceiver
        call class [System.Runtime]System.Type class IStaticInference`1<!!TElement>::GetElementType()
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type ValueElement<T>(valuetype InferredValueTarget&) cil managed noinlining
    {
        ldarg.0
        constrained. InferredValueTarget
        callvirt instance class [System.Runtime]System.Type class IValueInference`1<!!T>::GetElementType()
        ret
    }

    .method public hidebysig static int32 ValueIncrement<T>(valuetype InferredValueTarget&) cil managed noinlining
    {
        ldarg.0
        constrained. InferredValueTarget
        callvirt instance int32 class IValueInference`1<!!T>::Increment()
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type BoxElement<class T>(valuetype InferenceListBox`1<!!T>&) cil managed noinlining
    {
        ldarg.0
        constrained. valuetype InferenceListBox`1<!!T>
        callvirt instance class [System.Runtime]System.Type IBoxInference::GetElementType()
        ret
    }

    .method public hidebysig static int32 BoxIncrement<class T>(valuetype InferenceListBox`1<!!T>&) cil managed noinlining
    {
        ldarg.0
        constrained. valuetype InferenceListBox`1<!!T>
        callvirt instance int32 IBoxInference::Increment()
        ret
    }

}
