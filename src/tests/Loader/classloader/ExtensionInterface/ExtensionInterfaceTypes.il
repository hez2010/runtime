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
// Each byte[] is a four-byte element count followed by its signature bytes. The signatures
// below use ELEMENT_TYPE_VALUETYPE (11), CLASS (12), VAR (13), and GENERICINST (15).
// CLASS and VALUETYPE are followed by a compressed TypeDefOrRef token.
// TypeOwnedTarget : ITypeOwned -> TypeOwnedWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    08 00 00 02                   // Owner: TypeDef 0x02000008 (TypeOwnedTarget)
    0B 00 00 02                   // Implementation: TypeDef 0x0200000B (TypeOwnedWitness)
    02 00 00 00 12 20             // Target: CLASS TypeOwnedTarget
    02 00 00 00 12 10             // Interface: CLASS ITypeOwned
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// ConditionalTarget<T> : IConditional -> ConditionalWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    11 00 00 02                   // Owner: TypeDef 0x02000011 (ConditionalTarget`1)
    12 00 00 02                   // Implementation: TypeDef 0x02000012 (ConditionalWitness`1)
    06 00 00 00 15 12 44 01 13 00 // Target: GENERICINST CLASS ConditionalTarget`1<VAR 0>
    02 00 00 00 12 40             // Interface: CLASS IConditional
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// ValueTarget : IValueOwned -> ValueWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    0E 00 00 02                   // Owner: TypeDef 0x0200000E (ValueTarget)
    0F 00 00 02                   // Implementation: TypeDef 0x0200000F (ValueWitness)
    02 00 00 00 11 38             // Target: VALUETYPE ValueTarget
    02 00 00 00 12 34             // Interface: CLASS IValueOwned
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// T : IInterfaceOwned -> InterfaceOwnedWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    06 00 00 02                   // Owner: TypeDef 0x02000006 (IInterfaceOwned)
    0C 00 00 02                   // Implementation: TypeDef 0x0200000C (InterfaceOwnedWitness`1)
    02 00 00 00 13 00             // Target: VAR 0 (the witness type parameter T)
    02 00 00 00 12 18             // Interface: CLASS IInterfaceOwned
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// T : ISelfJustifying -> SelfJustifyingWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    13 00 00 02                   // Owner: TypeDef 0x02000013 (ISelfJustifying)
    14 00 00 02                   // Implementation: TypeDef 0x02000014 (SelfJustifyingWitness`1)
    02 00 00 00 13 00             // Target: VAR 0 (the witness type parameter T)
    02 00 00 00 12 4C             // Interface: CLASS ISelfJustifying
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// The two AmbiguousTarget rows deliberately violate coherence.
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    16 00 00 02                   // Owner: TypeDef 0x02000016 (AmbiguousTarget)
    17 00 00 02                   // Implementation: TypeDef 0x02000017 (AmbiguousWitnessA)
    02 00 00 00 12 58             // Target: CLASS AmbiguousTarget
    02 00 00 00 12 54             // Interface: CLASS IAmbiguous
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    16 00 00 02                   // Owner: TypeDef 0x02000016 (AmbiguousTarget)
    18 00 00 02                   // Implementation: TypeDef 0x02000018 (AmbiguousWitnessB)
    02 00 00 00 12 58             // Target: CLASS AmbiguousTarget
    02 00 00 00 12 54             // Interface: CLASS IAmbiguous
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)

// DevirtualizationTarget : IDevirtualized -> DevirtualizationWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    1A 00 00 02                   // Owner: TypeDef 0x0200001A (DevirtualizationTarget)
    1B 00 00 02                   // Implementation: TypeDef 0x0200001B (DevirtualizationWitness)
    02 00 00 00 12 68             // Target: CLASS DevirtualizationTarget
    02 00 00 00 12 64             // Interface: CLASS IDevirtualized
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// StaticTarget : IStaticOwned -> StaticWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    1D 00 00 02                   // Owner: TypeDef 0x0200001D (StaticTarget)
    1E 00 00 02                   // Implementation: TypeDef 0x0200001E (StaticWitness)
    02 00 00 00 11 74             // Target: VALUETYPE StaticTarget
    02 00 00 00 12 70             // Interface: CLASS IStaticOwned
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// StaticReferenceTarget : IStaticOwned -> StaticReferenceWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    20 00 00 02                   // Owner: TypeDef 0x02000020 (StaticReferenceTarget)
    21 00 00 02                   // Implementation: TypeDef 0x02000021 (StaticReferenceWitness)
    03 00 00 00 12 80 80          // Target: CLASS StaticReferenceTarget
    02 00 00 00 12 70             // Interface: CLASS IStaticOwned
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// GenericValueTarget<T> : IValueOwned -> GenericValueWitness<T> where T : ITypeOwned
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    23 00 00 02                   // Owner: TypeDef 0x02000023 (GenericValueTarget`1)
    24 00 00 02                   // Implementation: TypeDef 0x02000024 (GenericValueWitness`1)
    07 00 00 00 15 11 80 8C 01 13 00 // Target: GENERICINST VALUETYPE GenericValueTarget`1<VAR 0>
    02 00 00 00 12 34             // Interface: CLASS IValueOwned
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)

// Prototype ExtensionInterfaceMethodImpl rows:
//   int32 Implementation, int32 Declaration, int32 Body.
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    0B 00 00 02 // Implementation: TypeDef 0x0200000B (TypeOwnedWitness)
    03 00 00 06 // Declaration: MethodDef 0x06000003 (ITypeOwned.GetValue)
    0C 00 00 06 // Body: MethodDef 0x0600000C (TypeOwnedWitness.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    0C 00 00 02 // Implementation: TypeDef 0x0200000C (InterfaceOwnedWitness`1)
    05 00 00 06 // Declaration: MethodDef 0x06000005 (IInterfaceOwned.GetText)
    0E 00 00 06 // Body: MethodDef 0x0600000E (InterfaceOwnedWitness`1.GetTextBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    0C 00 00 02 // Implementation: TypeDef 0x0200000C (InterfaceOwnedWitness`1)
    04 00 00 06 // Declaration: MethodDef 0x06000004 (IBaseExtensionInterface.GetBaseValue)
    10 00 00 06 // Body: MethodDef 0x06000010 (InterfaceOwnedWitness`1.GetBaseValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    0F 00 00 02 // Implementation: TypeDef 0x0200000F (ValueWitness)
    11 00 00 06 // Declaration: MethodDef 0x06000011 (IValueOwned.GetValue)
    14 00 00 06 // Body: MethodDef 0x06000014 (ValueWitness.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    0F 00 00 02 // Implementation: TypeDef 0x0200000F (ValueWitness)
    12 00 00 06 // Declaration: MethodDef 0x06000012 (IValueOwned.Increment)
    16 00 00 06 // Body: MethodDef 0x06000016 (ValueWitness.IncrementBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    12 00 00 02 // Implementation: TypeDef 0x02000012 (ConditionalWitness`1)
    17 00 00 06 // Declaration: MethodDef 0x06000017 (IConditional.GetValue)
    1A 00 00 06 // Body: MethodDef 0x0600001A (ConditionalWitness`1.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    14 00 00 02 // Implementation: TypeDef 0x02000014 (SelfJustifyingWitness`1)
    1B 00 00 06 // Declaration: MethodDef 0x0600001B (ISelfJustifying.GetValue)
    1D 00 00 06 // Body: MethodDef 0x0600001D (SelfJustifyingWitness`1.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    17 00 00 02 // Implementation: TypeDef 0x02000017 (AmbiguousWitnessA)
    1E 00 00 06 // Declaration: MethodDef 0x0600001E (IAmbiguous.GetValue)
    21 00 00 06 // Body: MethodDef 0x06000021 (AmbiguousWitnessA.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    18 00 00 02 // Implementation: TypeDef 0x02000018 (AmbiguousWitnessB)
    1E 00 00 06 // Declaration: MethodDef 0x0600001E (IAmbiguous.GetValue)
    23 00 00 06 // Body: MethodDef 0x06000023 (AmbiguousWitnessB.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    1B 00 00 02 // Implementation: TypeDef 0x0200001B (DevirtualizationWitness)
    24 00 00 06 // Declaration: MethodDef 0x06000024 (IDevirtualized.GetValue)
    27 00 00 06 // Body: MethodDef 0x06000027 (DevirtualizationWitness.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    1E 00 00 02 // Implementation: TypeDef 0x0200001E (StaticWitness)
    28 00 00 06 // Declaration: MethodDef 0x06000028 (IStaticOwned.Create)
    29 00 00 06 // Body: MethodDef 0x06000029 (StaticWitness.CreateBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    21 00 00 02 // Implementation: TypeDef 0x02000021 (StaticReferenceWitness)
    28 00 00 06 // Declaration: MethodDef 0x06000028 (IStaticOwned.Create)
    30 00 00 06 // Body: MethodDef 0x06000030 (StaticReferenceWitness.CreateBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    24 00 00 02 // Implementation: TypeDef 0x02000024 (GenericValueWitness`1)
    11 00 00 06 // Declaration: MethodDef 0x06000011 (IValueOwned.GetValue)
    34 00 00 06 // Body: MethodDef 0x06000034 (GenericValueWitness`1.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    24 00 00 02 // Implementation: TypeDef 0x02000024 (GenericValueWitness`1)
    12 00 00 06 // Declaration: MethodDef 0x06000012 (IValueOwned.Increment)
    36 00 00 06 // Body: MethodDef 0x06000036 (GenericValueWitness`1.IncrementBody)
    00 00       // Named argument count: 0
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
        call int32 TypeOwnedWitness::GetValueBody(class TypeOwnedTarget)
        ret
    }

    .method private hidebysig static int32 GetValueBody(class TypeOwnedTarget) cil managed
    {
        ldarg.0
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
        ldarg.0
        castclass !T
        call string class InterfaceOwnedWitness`1<!T>::GetTextBody(!T)
        ret
    }

    .method private hidebysig static string GetTextBody(!T) cil managed
    {
        ldstr "interface-owned"
        ret
    }

    .method private final hidebysig newslot virtual instance int32 GetBaseValue() cil managed
    {
        .override IBaseExtensionInterface::GetBaseValue
        ldarg.0
        castclass !T
        call int32 class InterfaceOwnedWitness`1<!T>::GetBaseValueBody(!T)
        ret
    }

    .method private hidebysig static int32 GetBaseValueBody(!T) cil managed
    {
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
        call int32 ValueWitness::GetValueBody(valuetype ValueTarget&)
        ret
    }

    .method private hidebysig static int32 GetValueBody(valuetype ValueTarget&) cil managed
    {
        ldarg.0
        ldfld int32 ValueTarget::Value
        ret
    }

    .method private final hidebysig newslot virtual instance void Increment() cil managed
    {
        .override IValueOwned::Increment
        ldarg.0
        unbox ValueTarget
        call void ValueWitness::IncrementBody(valuetype ValueTarget&)
        ret
    }

    .method private hidebysig static void IncrementBody(valuetype ValueTarget&) cil managed
    {
        ldarg.0
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
        ldarg.0
        castclass class ConditionalTarget`1<!T>
        call int32 class ConditionalWitness`1<!T>::GetValueBody(class ConditionalTarget`1<!T>)
        ret
    }

    .method private hidebysig static int32 GetValueBody(class ConditionalTarget`1<!T>) cil managed
    {
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
        ldarg.0
        castclass !T
        call int32 class SelfJustifyingWitness`1<!T>::GetValueBody(!T)
        ret
    }

    .method private hidebysig static int32 GetValueBody(!T) cil managed
    {
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
        ldarg.0
        castclass AmbiguousTarget
        call int32 AmbiguousWitnessA::GetValueBody(class AmbiguousTarget)
        ret
    }

    .method private hidebysig static int32 GetValueBody(class AmbiguousTarget) cil managed
    {
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
        ldarg.0
        castclass AmbiguousTarget
        call int32 AmbiguousWitnessB::GetValueBody(class AmbiguousTarget)
        ret
    }

    .method private hidebysig static int32 GetValueBody(class AmbiguousTarget) cil managed
    {
        ldc.i4.2
        ret
    }
}

.class interface public abstract auto ansi IDevirtualized
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }
}

.class public auto ansi sealed beforefieldinit DevirtualizationTarget
    extends [System.Runtime]System.Object
{
    .field public initonly int32 _value

    .method public hidebysig specialname rtspecialname instance void .ctor(int32) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ldarg.0
        ldarg.1
        stfld int32 DevirtualizationTarget::_value
        ret
    }
}

.class interface private abstract auto ansi DevirtualizationWitness
    implements IDevirtualized
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IDevirtualized::GetValue
        ldarg.0
        castclass DevirtualizationTarget
        call int32 DevirtualizationWitness::GetValueBody(class DevirtualizationTarget)
        ret
    }

    .method private hidebysig static int32 GetValueBody(class DevirtualizationTarget) cil managed noinlining
    {
        ldarg.0
        ldfld int32 DevirtualizationTarget::_value
        ret
    }
}

.class interface public abstract auto ansi IStaticOwned
{
    .method public hidebysig newslot abstract virtual static int32 Create(int32) cil managed
    {
    }
}

.class public sequential ansi sealed beforefieldinit StaticTarget
    extends [System.Runtime]System.ValueType
{
}

.class interface private abstract auto ansi StaticWitness
    implements IStaticOwned
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private hidebysig static int32 CreateBody(int32) cil managed
    {
        .override IStaticOwned::Create
        ldarg.0
        ldc.i4.2
        add
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit Stage2Calls
    extends [System.Runtime]System.Object
{
    .method public hidebysig static int32 DirectReferenceCall(class DevirtualizationTarget) cil managed noinlining
    {
        ldarg.0
        callvirt instance int32 IDevirtualized::GetValue()
        ret
    }

    .method private hidebysig static void IncrementConstrained<(IValueOwned) T>(!!T&) cil managed noinlining
    {
        ldarg.0
        constrained. !!T
        callvirt instance void IValueOwned::Increment()
        ret
    }

    .method public hidebysig static int32 RunValueConstraint() cil managed noinlining
    {
        .locals init (valuetype ValueTarget V_0)

        ldloca.s V_0
        ldc.i4.s 10
        stfld int32 ValueTarget::Value
        ldloca.s V_0
        call void Stage2Calls::IncrementConstrained<valuetype ValueTarget>(!!0&)
        ldloca.s V_0
        ldfld int32 ValueTarget::Value
        ret
    }

    .method private hidebysig static int32 CreateConstrained<(IStaticOwned) T>(int32) cil managed noinlining
    {
        ldarg.0
        constrained. !!T
        call int32 IStaticOwned::Create(int32)
        ret
    }

    .method public hidebysig static int32 RunStaticConstraint() cil managed noinlining
    {
        ldc.i4.s 40
        call int32 Stage2Calls::CreateConstrained<valuetype StaticTarget>(int32)
        ret
    }
}

.class private auto ansi sealed beforefieldinit System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute
    extends [System.Runtime]System.Attribute
{
    .method public hidebysig specialname rtspecialname instance void .ctor(
        int32,
        int32,
        int32) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Attribute::.ctor()
        ret
    }
}

.class public auto ansi sealed beforefieldinit StaticReferenceTarget
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi StaticReferenceWitness
    implements IStaticOwned
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private hidebysig static int32 CreateBody(int32) cil managed
    {
        .override IStaticOwned::Create
        ldarg.0
        ldc.i4.3
        add
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit Stage2ReferenceCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static int32 CreateConstrained<class (IStaticOwned) T>(int32) cil managed noinlining
    {
        ldarg.0
        constrained. !!T
        call int32 IStaticOwned::Create(int32)
        ret
    }

    .method public hidebysig static int32 RunStaticConstraint() cil managed noinlining
    {
        ldc.i4.s 40
        call int32 Stage2ReferenceCalls::CreateConstrained<class StaticReferenceTarget>(int32)
        ret
    }
}

.class public sequential ansi sealed beforefieldinit GenericValueTarget`1<T>
    extends [System.Runtime]System.ValueType
{
    .field public int32 Value
}

.class interface private abstract auto ansi GenericValueWitness`1<(ITypeOwned) T>
    implements IValueOwned
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IValueOwned::GetValue
        ldarg.0
        unbox valuetype GenericValueTarget`1<!T>
        call int32 class GenericValueWitness`1<!T>::GetValueBody(valuetype GenericValueTarget`1<!T>&)
        ret
    }

    .method private hidebysig static int32 GetValueBody(valuetype GenericValueTarget`1<!T>&) cil managed
    {
        ldarg.0
        ldfld int32 valuetype GenericValueTarget`1<!T>::Value
        ret
    }

    .method private final hidebysig newslot virtual instance void Increment() cil managed
    {
        .override IValueOwned::Increment
        ldarg.0
        unbox valuetype GenericValueTarget`1<!T>
        call void class GenericValueWitness`1<!T>::IncrementBody(valuetype GenericValueTarget`1<!T>&)
        ret
    }

    .method private hidebysig static void IncrementBody(valuetype GenericValueTarget`1<!T>&) cil managed
    {
        ldarg.0
        dup
        ldfld int32 valuetype GenericValueTarget`1<!T>::Value
        ldc.i4.1
        add
        stfld int32 valuetype GenericValueTarget`1<!T>::Value
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit Stage2GenericValueCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static void IncrementConstrained<(IValueOwned) T>(!!T&) cil managed noinlining
    {
        ldarg.0
        constrained. !!T
        callvirt instance void IValueOwned::Increment()
        ret
    }

    .method public hidebysig static int32 Run() cil managed noinlining
    {
        .locals init (valuetype GenericValueTarget`1<class TypeOwnedTarget> V_0)

        ldloca.s V_0
        ldc.i4.s 20
        stfld int32 valuetype GenericValueTarget`1<class TypeOwnedTarget>::Value
        ldloca.s V_0
        call void Stage2GenericValueCalls::IncrementConstrained<valuetype GenericValueTarget`1<class TypeOwnedTarget>>(!!0&)
        ldloca.s V_0
        ldfld int32 valuetype GenericValueTarget`1<class TypeOwnedTarget>::Value
        ret
    }
}
