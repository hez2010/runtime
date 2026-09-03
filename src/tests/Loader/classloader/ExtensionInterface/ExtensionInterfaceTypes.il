// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime
{
    .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A)
}
.assembly ExtensionInterfaceTypes { }
.module ExtensionInterfaceTypes.dll

// Prototype manifest rows have the same logical fields as ExtensionInterfaceImpl:
//   int32 Owner, int32 Implementation, byte[] Target, byte[] Interface, uint16 Flags.
// The signature arrays are ordinary CLI type signatures in the witness generic context.
// TypeOwnedTarget : ITypeOwned -> TypeOwnedWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    07 00 00 02
    0A 00 00 02
    02 00 00 00 12 1C
    02 00 00 00 12 0C
    01 00
    00 00
)
// ConditionalTarget<T> : IConditional -> ConditionalWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    10 00 00 02
    11 00 00 02
    06 00 00 00 15 12 40 01 13 00
    02 00 00 00 12 3C
    01 00
    00 00
)
// ValueTarget : IValueOwned -> ValueWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    0D 00 00 02
    0E 00 00 02
    02 00 00 00 11 34
    02 00 00 00 12 30
    01 00
    00 00
)
// T : IInterfaceOwned -> InterfaceOwnedWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    05 00 00 02
    0B 00 00 02
    02 00 00 00 13 00
    02 00 00 00 12 14
    02 00
    00 00
)
// T : ISelfJustifying -> SelfJustifyingWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    12 00 00 02
    13 00 00 02
    02 00 00 00 13 00
    02 00 00 00 12 48
    02 00
    00 00
)
// The two AmbiguousTarget rows deliberately violate coherence.
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    15 00 00 02
    16 00 00 02
    02 00 00 00 12 54
    02 00 00 00 12 50
    01 00
    00 00
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    15 00 00 02
    17 00 00 02
    02 00 00 00 12 54
    02 00 00 00 12 50
    01 00
    00 00
)

.class private auto ansi sealed beforefieldinit System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute
    extends [System.Runtime]System.Attribute
{
    .method public hidebysig specialname rtspecialname instance void .ctor(
        int32,
        int32,
        uint8[],
        uint8[],
        uint16) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Attribute::.ctor()
        ret
    }
}

.class interface public abstract auto ansi ITypeOwned
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }
}

.class interface public abstract auto ansi IBaseExtensionInterface
{
    .method public hidebysig newslot abstract virtual instance int32 GetBaseValue() cil managed
    {
    }
}

.class interface public abstract auto ansi IInterfaceOwned
    implements IBaseExtensionInterface
{
    .method public hidebysig newslot abstract virtual instance string GetText() cil managed
    {
    }
}

.class interface public abstract auto ansi INonParticipating
{
}

.class public auto ansi beforefieldinit TypeOwnedTarget
    extends [System.Runtime]System.Object
{
    .field public initonly int32 _value

    .method public hidebysig specialname rtspecialname instance void .ctor(int32) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ldarg.0
        ldarg.1
        stfld int32 TypeOwnedTarget::_value
        ret
    }
}

.class public auto ansi beforefieldinit DerivedTypeOwnedTarget
    extends TypeOwnedTarget
{
    .method public hidebysig specialname rtspecialname instance void .ctor(int32) cil managed
    {
        ldarg.0
        ldarg.1
        call instance void TypeOwnedTarget::.ctor(int32)
        ret
    }
}

.class public auto ansi beforefieldinit NominalTarget
    extends [System.Runtime]System.Object
    implements IInterfaceOwned
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

    .method public final hidebysig newslot virtual instance string GetText() cil managed
    {
        ldstr "nominal"
        ret
    }

    .method public final hidebysig newslot virtual instance int32 GetBaseValue() cil managed
    {
        ldc.i4.s 77
        ret
    }
}

.class interface private abstract auto ansi TypeOwnedWitness
    implements ITypeOwned
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override ITypeOwned::GetValue
        ldarg.0
        castclass TypeOwnedTarget
        ldfld int32 TypeOwnedTarget::_value
        ret
    }
}

.class interface private abstract auto ansi InterfaceOwnedWitness`1<class T>
    implements IInterfaceOwned
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance string GetText() cil managed
    {
        .override IInterfaceOwned::GetText
        ldstr "interface-owned"
        ret
    }

    .method private final hidebysig newslot virtual instance int32 GetBaseValue() cil managed
    {
        .override IBaseExtensionInterface::GetBaseValue
        ldc.i4.s 31
        ret
    }
}

.class interface public abstract auto ansi IValueOwned
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }

    .method public hidebysig newslot abstract virtual instance void Increment() cil managed
    {
    }
}

.class public sequential ansi sealed beforefieldinit ValueTarget
    extends [System.Runtime]System.ValueType
{
    .field public int32 Value
}

.class interface private abstract auto ansi ValueWitness
    implements IValueOwned
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IValueOwned::GetValue
        ldarg.0
        unbox ValueTarget
        ldfld int32 ValueTarget::Value
        ret
    }

    .method private final hidebysig newslot virtual instance void Increment() cil managed
    {
        .override IValueOwned::Increment
        ldarg.0
        unbox ValueTarget
        dup
        ldfld int32 ValueTarget::Value
        ldc.i4.1
        add
        stfld int32 ValueTarget::Value
        ret
    }
}

.class interface public abstract auto ansi IConditional
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }
}

.class public auto ansi beforefieldinit ConditionalTarget`1<T>
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi ConditionalWitness`1<(ITypeOwned) T>
    implements IConditional
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IConditional::GetValue
        ldc.i4.s 123
        ret
    }
}

.class interface public abstract auto ansi ISelfJustifying
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }
}

.class interface private abstract auto ansi SelfJustifyingWitness`1<class (ISelfJustifying) T>
    implements ISelfJustifying
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override ISelfJustifying::GetValue
        ldc.i4.1
        ret
    }
}

.class interface public abstract auto ansi IAmbiguous
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }
}

.class public auto ansi beforefieldinit AmbiguousTarget
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi AmbiguousWitnessA
    implements IAmbiguous
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IAmbiguous::GetValue
        ldc.i4.1
        ret
    }
}

.class interface private abstract auto ansi AmbiguousWitnessB
    implements IAmbiguous
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IAmbiguous::GetValue
        ldc.i4.2
        ret
    }
}
