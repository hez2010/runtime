// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly extern System.Collections { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly extern ExtensionInterfaceForeignTypes { }
.assembly ResolutionBridgeTypes { }
.module ResolutionBridgeTypes.dll

// Manifest tokens refer to the definitions below. Preserve declaration order.
// IChainFirst -> ChainFirstClassWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 04 00 00 02 05 00 00 02 02 00 00 00 12 0D 02 00 00 00 12 10 02 00 00 00
)
// IChainFirst -> ChainFirstValueWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 04 00 00 02 06 00 00 02 02 00 00 00 11 11 02 00 00 00 12 10 02 00 00 00
)
// IChainFirst`1 -> GenericChainFirstWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 07 00 00 02 08 00 00 02 02 00 00 00 12 0D 06 00 00 00 15 12 1C 01 13 00 02 00 00 00
)
// IChainFirst -> GenericValueChainFirstWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 04 00 00 02 09 00 00 02 06 00 00 00 15 11 15 01 13 00 02 00 00 00 12 10 02 00 00 00
)
// IChainFirst.GetValue -> ChainFirstClassWitness.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 05 00 00 02 03 00 00 06 05 00 00 06 00 00
)
// IChainFirst.GetValue -> ChainFirstValueWitness.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 06 00 00 02 03 00 00 06 07 00 00 06 00 00
)
// IChainFirst`1.GetValue -> GenericChainFirstWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 08 00 00 02 08 00 00 06 0A 00 00 06 00 00
)
// IChainFirst.GetValue -> GenericValueChainFirstWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 09 00 00 02 03 00 00 06 0C 00 00 06 00 00
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

.class interface public abstract auto ansi IChainFirst
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi ChainFirstClassWitness implements IChainFirst
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 IChainFirst::GetValue()
        ldarg.0
        castclass class [ExtensionInterfaceForeignTypes]ForeignChainReceiver
        call int32 ChainFirstClassWitness::Body(class [ExtensionInterfaceForeignTypes]ForeignChainReceiver)
        ret
    }

    .method private hidebysig static int32 Body(class [ExtensionInterfaceForeignTypes]ForeignChainReceiver) cil managed
    {
        ldc.i4.s 71
        ret
    }

}

.class interface public abstract auto ansi ChainFirstValueWitness implements IChainFirst
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 IChainFirst::GetValue()
        ldarg.0
        unbox valuetype [ExtensionInterfaceForeignTypes]ForeignChainValue
        call int32 ChainFirstValueWitness::Body(valuetype [ExtensionInterfaceForeignTypes]ForeignChainValue&)
        ret
    }

    .method private hidebysig static int32 Body(valuetype [ExtensionInterfaceForeignTypes]ForeignChainValue&) cil managed
    {
        ldc.i4.s 71
        ret
    }

}

.class interface public abstract auto ansi IChainFirst`1<T>
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi GenericChainFirstWitness`1<T> implements class IChainFirst`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 class IChainFirst`1<!T>::GetValue()
        ldarg.0
        castclass class [ExtensionInterfaceForeignTypes]ForeignChainReceiver
        call int32 class GenericChainFirstWitness`1<!T>::Body(class [ExtensionInterfaceForeignTypes]ForeignChainReceiver)
        ret
    }

    .method private hidebysig static int32 Body(class [ExtensionInterfaceForeignTypes]ForeignChainReceiver) cil managed
    {
        ldc.i4.s 71
        ret
    }

}

.class interface public abstract auto ansi GenericValueChainFirstWitness`1<T> implements IChainFirst
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 IChainFirst::GetValue()
        ldarg.0
        unbox valuetype [ExtensionInterfaceForeignTypes]ForeignGenericChainValue`1<!T>
        call int32 class GenericValueChainFirstWitness`1<!T>::Body(valuetype [ExtensionInterfaceForeignTypes]ForeignGenericChainValue`1<!T>&)
        ret
    }

    .method private hidebysig static int32 Body(valuetype [ExtensionInterfaceForeignTypes]ForeignGenericChainValue`1<!T>&) cil managed
    {
        ldc.i4.s 71
        ret
    }

}

