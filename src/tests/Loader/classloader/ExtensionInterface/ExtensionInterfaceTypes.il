// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime
{
    .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A)
}
.assembly extern ExtensionInterfaceForeignTypes { }
.assembly ExtensionInterfaceTypes { }
.module ExtensionInterfaceTypes.dll

// Prototype manifest rows have the same logical fields as ExtensionInterfaceImpl:
//   int32 Owner, int32 Implementation, byte[] Target, byte[] Interface, uint16 Flags.
// The signature arrays are ordinary CLI type signatures in the witness generic context.
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
// int32 : IFoo -> IntFooWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    26 00 00 02                   // Owner: TypeDef 0x02000026 (IFoo)
    27 00 00 02                   // Implementation: TypeDef 0x02000027 (IntFooWitness)
    01 00 00 00 08                // Target: I4 (System.Int32)
    03 00 00 00 12 80 98          // Interface: CLASS IFoo
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// string : IFoo -> StringFooWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    26 00 00 02                   // Owner: TypeDef 0x02000026 (IFoo)
    50 00 00 02                   // Implementation: TypeDef 0x02000050 (StringFooWitness)
    01 00 00 00 0E                // Target: STRING (System.String)
    03 00 00 00 12 80 98          // Interface: CLASS IFoo
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)

// Declared interfaces implemented for foreign types.
// ForeignOrdinaryClass : IDeclaredOrdinaryClass -> ForeignOrdinaryClassWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    29 00 00 02                   // Owner: TypeDef 0x02000029 (IDeclaredOrdinaryClass)
    2E 00 00 02                   // Implementation: TypeDef 0x0200002E (ForeignOrdinaryClassWitness)
    02 00 00 00 12 35             // Target: CLASS ForeignOrdinaryClass (TypeRef 0x0100000D)
    03 00 00 00 12 80 A4          // Interface: CLASS IDeclaredOrdinaryClass
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// ForeignOrdinaryStruct : IDeclaredOrdinaryStruct -> ForeignOrdinaryStructWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    2A 00 00 02                   // Owner: TypeDef 0x0200002A (IDeclaredOrdinaryStruct)
    2F 00 00 02                   // Implementation: TypeDef 0x0200002F (ForeignOrdinaryStructWitness)
    02 00 00 00 11 39             // Target: VALUETYPE ForeignOrdinaryStruct (TypeRef 0x0100000E)
    03 00 00 00 12 80 A8          // Interface: CLASS IDeclaredOrdinaryStruct
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// ForeignGenericClass<T> : IDeclaredGeneric<T> -> ForeignGenericClassWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    2B 00 00 02                   // Owner: TypeDef 0x0200002B (IDeclaredGeneric`1)
    30 00 00 02                   // Implementation: TypeDef 0x02000030 (ForeignGenericClassWitness`1)
    06 00 00 00 15 12 3D 01 13 00 // Target: GENERICINST CLASS ForeignGenericClass`1<VAR 0>
    07 00 00 00 15 12 80 AC 01 13 00 // Interface: GENERICINST CLASS IDeclaredGeneric`1<VAR 0>
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// ForeignGenericStruct<T> : IDeclaredGeneric<T> -> ForeignGenericStructWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    2B 00 00 02                   // Owner: TypeDef 0x0200002B (IDeclaredGeneric`1)
    31 00 00 02                   // Implementation: TypeDef 0x02000031 (ForeignGenericStructWitness`1)
    06 00 00 00 15 11 41 01 13 00 // Target: GENERICINST VALUETYPE ForeignGenericStruct`1<VAR 0>
    07 00 00 00 15 12 80 AC 01 13 00 // Interface: GENERICINST CLASS IDeclaredGeneric`1<VAR 0>
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// ForeignConditionalClass<T> : IDeclaredConditional<T> -> ForeignConditionalClassWitness<T> where T : IFoo
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    2C 00 00 02                   // Owner: TypeDef 0x0200002C (IDeclaredConditional`1)
    32 00 00 02                   // Implementation: TypeDef 0x02000032 (ForeignConditionalClassWitness`1)
    06 00 00 00 15 12 45 01 13 00 // Target: GENERICINST CLASS ForeignConditionalClass`1<VAR 0>
    07 00 00 00 15 12 80 B0 01 13 00 // Interface: GENERICINST CLASS IDeclaredConditional`1<VAR 0>
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// ForeignNestedClass<ForeignGenericStruct<T>> : IDeclaredNested<T> -> ForeignNestedWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    2D 00 00 02                   // Owner: TypeDef 0x0200002D (IDeclaredNested`1)
    33 00 00 02                   // Implementation: TypeDef 0x02000033 (ForeignNestedWitness`1)
    0A 00 00 00 15 12 49 01 15 11 41 01 13 00 // Target: ForeignNestedClass`1<ForeignGenericStruct`1<VAR 0>>
    07 00 00 00 15 12 80 B4 01 13 00 // Interface: GENERICINST CLASS IDeclaredNested`1<VAR 0>
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)

// Foreign interfaces implemented for declared types.
// DeclaredOrdinaryClass : IForeignOrdinaryClass -> DeclaredOrdinaryClassWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    34 00 00 02                   // Owner: TypeDef 0x02000034 (DeclaredOrdinaryClass)
    3A 00 00 02                   // Implementation: TypeDef 0x0200003A (DeclaredOrdinaryClassWitness)
    03 00 00 00 12 80 D0          // Target: CLASS DeclaredOrdinaryClass
    02 00 00 00 12 21             // Interface: CLASS IForeignOrdinaryClass (TypeRef 0x01000008)
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredOrdinaryStruct : IForeignOrdinaryStruct -> DeclaredOrdinaryStructWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    35 00 00 02                   // Owner: TypeDef 0x02000035 (DeclaredOrdinaryStruct)
    3B 00 00 02                   // Implementation: TypeDef 0x0200003B (DeclaredOrdinaryStructWitness)
    03 00 00 00 11 80 D4          // Target: VALUETYPE DeclaredOrdinaryStruct
    02 00 00 00 12 25             // Interface: CLASS IForeignOrdinaryStruct (TypeRef 0x01000009)
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredGenericClass<T> : IForeignGeneric<T> -> DeclaredGenericClassWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    36 00 00 02                   // Owner: TypeDef 0x02000036 (DeclaredGenericClass`1)
    3C 00 00 02                   // Implementation: TypeDef 0x0200003C (DeclaredGenericClassWitness`1)
    07 00 00 00 15 12 80 D8 01 13 00 // Target: GENERICINST CLASS DeclaredGenericClass`1<VAR 0>
    06 00 00 00 15 12 29 01 13 00 // Interface: GENERICINST CLASS IForeignGeneric`1<VAR 0>
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredGenericStruct<T> : IForeignGeneric<T> -> DeclaredGenericStructWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    37 00 00 02                   // Owner: TypeDef 0x02000037 (DeclaredGenericStruct`1)
    3D 00 00 02                   // Implementation: TypeDef 0x0200003D (DeclaredGenericStructWitness`1)
    07 00 00 00 15 11 80 DC 01 13 00 // Target: GENERICINST VALUETYPE DeclaredGenericStruct`1<VAR 0>
    06 00 00 00 15 12 29 01 13 00 // Interface: GENERICINST CLASS IForeignGeneric`1<VAR 0>
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredConditionalClass<T> : IForeignConditional<T> -> DeclaredConditionalClassWitness<T> where T : IFoo
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    38 00 00 02                   // Owner: TypeDef 0x02000038 (DeclaredConditionalClass`1)
    3E 00 00 02                   // Implementation: TypeDef 0x0200003E (DeclaredConditionalClassWitness`1)
    07 00 00 00 15 12 80 E0 01 13 00 // Target: GENERICINST CLASS DeclaredConditionalClass`1<VAR 0>
    06 00 00 00 15 12 2D 01 13 00 // Interface: GENERICINST CLASS IForeignConditional`1<VAR 0>
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredNestedClass<ForeignGenericStruct<T>> : IForeignNested<T> -> DeclaredNestedWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    39 00 00 02                   // Owner: TypeDef 0x02000039 (DeclaredNestedClass`1)
    3F 00 00 02                   // Implementation: TypeDef 0x0200003F (DeclaredNestedWitness`1)
    0B 00 00 00 15 12 80 E4 01 15 11 41 01 13 00 // Target: DeclaredNestedClass`1<ForeignGenericStruct`1<VAR 0>>
    06 00 00 00 15 12 31 01 13 00 // Interface: GENERICINST CLASS IForeignNested`1<VAR 0>
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)

// Generic virtual method declarations.
// ForeignGenericMethodClass : IDeclaredGenericMethod -> ForeignGenericMethodClassWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    41 00 00 02                   // Owner: TypeDef 0x02000041 (IDeclaredGenericMethod)
    42 00 00 02                   // Implementation: TypeDef 0x02000042 (ForeignGenericMethodClassWitness)
    02 00 00 00 12 4D             // Target: CLASS ForeignGenericMethodClass (TypeRef 0x01000013)
    03 00 00 00 12 81 04          // Interface: CLASS IDeclaredGenericMethod
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// ForeignGenericMethodStruct : IDeclaredGenericMethod -> ForeignGenericMethodStructWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    41 00 00 02                   // Owner: TypeDef 0x02000041 (IDeclaredGenericMethod)
    43 00 00 02                   // Implementation: TypeDef 0x02000043 (ForeignGenericMethodStructWitness)
    02 00 00 00 11 51             // Target: VALUETYPE ForeignGenericMethodStruct (TypeRef 0x01000014)
    03 00 00 00 12 81 04          // Interface: CLASS IDeclaredGenericMethod
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// DeclaredGenericMethodClass : IForeignGenericMethod -> DeclaredGenericMethodClassWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    44 00 00 02                   // Owner: TypeDef 0x02000044 (DeclaredGenericMethodClass)
    46 00 00 02                   // Implementation: TypeDef 0x02000046 (DeclaredGenericMethodClassWitness)
    03 00 00 00 12 81 10          // Target: CLASS DeclaredGenericMethodClass
    02 00 00 00 12 55             // Interface: CLASS IForeignGenericMethod (TypeRef 0x01000015)
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredGenericMethodStruct : IForeignGenericMethod -> DeclaredGenericMethodStructWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    45 00 00 02                   // Owner: TypeDef 0x02000045 (DeclaredGenericMethodStruct)
    47 00 00 02                   // Implementation: TypeDef 0x02000047 (DeclaredGenericMethodStructWitness)
    03 00 00 00 11 81 14          // Target: VALUETYPE DeclaredGenericMethodStruct
    02 00 00 00 12 55             // Interface: CLASS IForeignGenericMethod (TypeRef 0x01000015)
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// DeclaredMethodArgument : IForeignMethodConstraint -> DeclaredMethodArgumentWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    49 00 00 02                   // Owner: TypeDef 0x02000049 (DeclaredMethodArgument)
    4A 00 00 02                   // Implementation: TypeDef 0x0200004A (DeclaredMethodArgumentWitness)
    03 00 00 00 12 81 24          // Target: CLASS DeclaredMethodArgument
    02 00 00 00 12 59             // Interface: CLASS IForeignMethodConstraint (TypeRef 0x01000016)
    01 00                         // Flags: TypeOwned
    00 00                         // Named argument count: 0
)
// ForeignGenericTypeMethodClass<T> : IDeclaredGenericTypeMethod<T> -> ForeignGenericTypeMethodWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    4B 00 00 02                   // Owner: TypeDef 0x0200004B (IDeclaredGenericTypeMethod`1)
    4C 00 00 02                   // Implementation: TypeDef 0x0200004C (ForeignGenericTypeMethodWitness`1)
    06 00 00 00 15 12 5D 01 13 00 // Target: GENERICINST CLASS ForeignGenericTypeMethodClass`1<VAR 0>
    07 00 00 00 15 12 81 2C 01 13 00 // Interface: GENERICINST CLASS IDeclaredGenericTypeMethod`1<VAR 0>
    02 00                         // Flags: InterfaceOwned
    00 00                         // Named argument count: 0
)
// DeclaredGenericTypeMethodClass<T> : IForeignGenericTypeMethod<T> -> DeclaredGenericTypeMethodWitness<T>
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00                         // Custom attribute prolog
    4D 00 00 02                   // Owner: TypeDef 0x0200004D (DeclaredGenericTypeMethodClass`1)
    4E 00 00 02                   // Implementation: TypeDef 0x0200004E (DeclaredGenericTypeMethodWitness`1)
    07 00 00 00 15 12 81 34 01 13 00 // Target: GENERICINST CLASS DeclaredGenericTypeMethodClass`1<VAR 0>
    06 00 00 00 15 12 61 01 13 00 // Interface: GENERICINST CLASS IForeignGenericTypeMethod`1<VAR 0>
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
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    27 00 00 02 // Implementation: TypeDef 0x02000027 (IntFooWitness)
    39 00 00 06 // Declaration: MethodDef 0x06000039 (IFoo.GetValue)
    3B 00 00 06 // Body: MethodDef 0x0600003B (IntFooWitness.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    50 00 00 02 // Implementation: TypeDef 0x02000050 (StringFooWitness)
    39 00 00 06 // Declaration: MethodDef 0x06000039 (IFoo.GetValue)
    83 00 00 06 // Body: MethodDef 0x06000083 (StringFooWitness.GetValueBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    42 00 00 02 // Implementation: TypeDef 0x02000042 (ForeignGenericMethodClassWitness)
    5E 00 00 06 // Declaration: MethodDef 0x0600005E (IDeclaredGenericMethod.Invoke)
    61 00 00 06 // Body: MethodDef 0x06000061 (ForeignGenericMethodClassWitness.InvokeBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    43 00 00 02 // Implementation: TypeDef 0x02000043 (ForeignGenericMethodStructWitness)
    5E 00 00 06 // Declaration: MethodDef 0x0600005E (IDeclaredGenericMethod.Invoke)
    65 00 00 06 // Body: MethodDef 0x06000065 (ForeignGenericMethodStructWitness.InvokeBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    46 00 00 02 // Implementation: TypeDef 0x02000046 (DeclaredGenericMethodClassWitness)
    16 00 00 0A // Declaration: MemberRef 0x0A000016 (IForeignGenericMethod.Invoke)
    6A 00 00 06 // Body: MethodDef 0x0600006A (DeclaredGenericMethodClassWitness.InvokeBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    47 00 00 02 // Implementation: TypeDef 0x02000047 (DeclaredGenericMethodStructWitness)
    16 00 00 0A // Declaration: MemberRef 0x0A000016 (IForeignGenericMethod.Invoke)
    6E 00 00 06 // Body: MethodDef 0x0600006E (DeclaredGenericMethodStructWitness.InvokeBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    42 00 00 02 // Implementation: TypeDef 0x02000042 (ForeignGenericMethodClassWitness)
    5F 00 00 06 // Declaration: MethodDef 0x0600005F (IDeclaredGenericMethod.InvokeConstrained)
    63 00 00 06 // Body: MethodDef 0x06000063 (ForeignGenericMethodClassWitness.InvokeConstrainedBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    43 00 00 02 // Implementation: TypeDef 0x02000043 (ForeignGenericMethodStructWitness)
    5F 00 00 06 // Declaration: MethodDef 0x0600005F (IDeclaredGenericMethod.InvokeConstrained)
    67 00 00 06 // Body: MethodDef 0x06000067 (ForeignGenericMethodStructWitness.InvokeConstrainedBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    46 00 00 02 // Implementation: TypeDef 0x02000046 (DeclaredGenericMethodClassWitness)
    17 00 00 0A // Declaration: MemberRef 0x0A000017 (IForeignGenericMethod.InvokeConstrained)
    6C 00 00 06 // Body: MethodDef 0x0600006C (DeclaredGenericMethodClassWitness.InvokeConstrainedBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    47 00 00 02 // Implementation: TypeDef 0x02000047 (DeclaredGenericMethodStructWitness)
    17 00 00 0A // Declaration: MemberRef 0x0A000017 (IForeignGenericMethod.InvokeConstrained)
    70 00 00 06 // Body: MethodDef 0x06000070 (DeclaredGenericMethodStructWitness.InvokeConstrainedBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    4C 00 00 02 // Implementation: TypeDef 0x0200004C (ForeignGenericTypeMethodWitness`1)
    78 00 00 06 // Declaration: MethodDef 0x06000078 (IDeclaredGenericTypeMethod`1.Invoke)
    7A 00 00 06 // Body: MethodDef 0x0600007A (ForeignGenericTypeMethodWitness`1.InvokeBody)
    00 00       // Named argument count: 0
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00       // Custom attribute prolog
    4E 00 00 02 // Implementation: TypeDef 0x0200004E (DeclaredGenericTypeMethodWitness`1)
    1B 00 00 0A // Declaration: MemberRef 0x0A00001B (IForeignGenericTypeMethod`1.Invoke)
    7D 00 00 06 // Body: MethodDef 0x0600007D (DeclaredGenericTypeMethodWitness`1.InvokeBody)
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

.class public abstract auto ansi sealed beforefieldinit CanonicalCalls
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
        call void CanonicalCalls::IncrementConstrained<valuetype ValueTarget>(!!0&)
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
        call int32 CanonicalCalls::CreateConstrained<valuetype StaticTarget>(int32)
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

.class public abstract auto ansi sealed beforefieldinit ReferenceCalls
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
        call int32 ReferenceCalls::CreateConstrained<class StaticReferenceTarget>(int32)
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

.class public abstract auto ansi sealed beforefieldinit GenericValueCalls
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
        call void GenericValueCalls::IncrementConstrained<valuetype GenericValueTarget`1<class TypeOwnedTarget>>(!!0&)
        ldloca.s V_0
        ldfld int32 valuetype GenericValueTarget`1<class TypeOwnedTarget>::Value
        ret
    }
}

.class interface public abstract auto ansi IFoo
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }
}

.class interface private abstract auto ansi IntFooWitness
    implements IFoo
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IFoo::GetValue
        ldarg.0
        unbox [System.Runtime]System.Int32
        call int32 IntFooWitness::GetValueBody(int32&)
        ret
    }

    .method private hidebysig static int32 GetValueBody(int32&) cil managed
    {
        ldarg.0
        ldind.i4
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit GenericIdentityCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static class [System.Runtime]System.Type GetReferenceType<class (ITypeOwned) T>(!!T) cil managed noinlining
    {
        ldarga.s 0
        constrained. !!T
        callvirt instance int32 ITypeOwned::GetValue()
        ldc.i4.s 42
        beq.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetValueType<(IFoo) T>(!!T) cil managed noinlining
    {
        ldarga.s 0
        constrained. !!T
        callvirt instance int32 IFoo::GetValue()
        ldc.i4.s 42
        beq.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunReferenceType() cil managed noinlining
    {
        ldc.i4.s 42
        newobj instance void TypeOwnedTarget::.ctor(int32)
        call class [System.Runtime]System.Type GenericIdentityCalls::GetReferenceType<class TypeOwnedTarget>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunValueType() cil managed noinlining
    {
        ldc.i4.s 42
        call class [System.Runtime]System.Type GenericIdentityCalls::GetValueType<int32>(!!0)
        ret
    }
}

.class interface public abstract auto ansi IDeclaredOrdinaryClass { }
.class interface public abstract auto ansi IDeclaredOrdinaryStruct { }
.class interface public abstract auto ansi IDeclaredGeneric`1<T> { }
.class interface public abstract auto ansi IDeclaredConditional`1<T> { }
.class interface public abstract auto ansi IDeclaredNested`1<T> { }

.class interface private abstract auto ansi ForeignOrdinaryClassWitness
    implements IDeclaredOrdinaryClass
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi ForeignOrdinaryStructWitness
    implements IDeclaredOrdinaryStruct
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi ForeignGenericClassWitness`1<T>
    implements class IDeclaredGeneric`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi ForeignGenericStructWitness`1<T>
    implements class IDeclaredGeneric`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi ForeignConditionalClassWitness`1<(IFoo) T>
    implements class IDeclaredConditional`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi ForeignNestedWitness`1<T>
    implements class IDeclaredNested`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class public auto ansi beforefieldinit DeclaredOrdinaryClass
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class public sequential ansi sealed beforefieldinit DeclaredOrdinaryStruct
    extends [System.Runtime]System.ValueType
{
    .field public int32 Value
}

.class public auto ansi beforefieldinit DeclaredGenericClass`1<T>
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class public sequential ansi sealed beforefieldinit DeclaredGenericStruct`1<T>
    extends [System.Runtime]System.ValueType
{
    .field public !T Value
}

.class public auto ansi beforefieldinit DeclaredConditionalClass`1<T>
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class public auto ansi beforefieldinit DeclaredNestedClass`1<T>
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi DeclaredOrdinaryClassWitness
    implements [ExtensionInterfaceForeignTypes]IForeignOrdinaryClass
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi DeclaredOrdinaryStructWitness
    implements [ExtensionInterfaceForeignTypes]IForeignOrdinaryStruct
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi DeclaredGenericClassWitness`1<T>
    implements class [ExtensionInterfaceForeignTypes]IForeignGeneric`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi DeclaredGenericStructWitness`1<T>
    implements class [ExtensionInterfaceForeignTypes]IForeignGeneric`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi DeclaredConditionalClassWitness`1<(IFoo) T>
    implements class [ExtensionInterfaceForeignTypes]IForeignConditional`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface private abstract auto ansi DeclaredNestedWitness`1<T>
    implements class [ExtensionInterfaceForeignTypes]IForeignNested`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class public abstract auto ansi sealed beforefieldinit IdentityMatrixCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static class [System.Runtime]System.Type GetForeignOrdinaryClassType<(IDeclaredOrdinaryClass) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignOrdinaryStructType<(IDeclaredOrdinaryStruct) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignGenericClassType<(class IDeclaredGeneric`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignGenericStructType<(class IDeclaredGeneric`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignConditionalClassType<(class IDeclaredConditional`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignNestedType<(class IDeclaredNested`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredOrdinaryClassType<([ExtensionInterfaceForeignTypes]IForeignOrdinaryClass) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredOrdinaryStructType<([ExtensionInterfaceForeignTypes]IForeignOrdinaryStruct) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredGenericClassType<(class [ExtensionInterfaceForeignTypes]IForeignGeneric`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredGenericStructType<(class [ExtensionInterfaceForeignTypes]IForeignGeneric`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredConditionalClassType<(class [ExtensionInterfaceForeignTypes]IForeignConditional`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredNestedType<(class [ExtensionInterfaceForeignTypes]IForeignNested`1<int32>) T>(!!T) cil managed noinlining
    {
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignOrdinaryClass() cil managed noinlining
    {
        newobj instance void [ExtensionInterfaceForeignTypes]ForeignOrdinaryClass::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetForeignOrdinaryClassType<class [ExtensionInterfaceForeignTypes]ForeignOrdinaryClass>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignOrdinaryStruct() cil managed noinlining
    {
        .locals init (valuetype [ExtensionInterfaceForeignTypes]ForeignOrdinaryStruct V_0)
        ldloca.s V_0
        initobj [ExtensionInterfaceForeignTypes]ForeignOrdinaryStruct
        ldloc.0
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetForeignOrdinaryStructType<valuetype [ExtensionInterfaceForeignTypes]ForeignOrdinaryStruct>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignGenericClass() cil managed noinlining
    {
        newobj instance void class [ExtensionInterfaceForeignTypes]ForeignGenericClass`1<int32>::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetForeignGenericClassType<class [ExtensionInterfaceForeignTypes]ForeignGenericClass`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignGenericStruct() cil managed noinlining
    {
        .locals init (valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32> V_0)
        ldloca.s V_0
        initobj valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32>
        ldloc.0
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetForeignGenericStructType<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignConditionalClass() cil managed noinlining
    {
        newobj instance void class [ExtensionInterfaceForeignTypes]ForeignConditionalClass`1<int32>::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetForeignConditionalClassType<class [ExtensionInterfaceForeignTypes]ForeignConditionalClass`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignNested() cil managed noinlining
    {
        newobj instance void class [ExtensionInterfaceForeignTypes]ForeignNestedClass`1<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32>>::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetForeignNestedType<class [ExtensionInterfaceForeignTypes]ForeignNestedClass`1<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32>>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredOrdinaryClass() cil managed noinlining
    {
        newobj instance void DeclaredOrdinaryClass::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetDeclaredOrdinaryClassType<class DeclaredOrdinaryClass>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredOrdinaryStruct() cil managed noinlining
    {
        .locals init (valuetype DeclaredOrdinaryStruct V_0)
        ldloca.s V_0
        initobj DeclaredOrdinaryStruct
        ldloc.0
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetDeclaredOrdinaryStructType<valuetype DeclaredOrdinaryStruct>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredGenericClass() cil managed noinlining
    {
        newobj instance void class DeclaredGenericClass`1<int32>::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetDeclaredGenericClassType<class DeclaredGenericClass`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredGenericStruct() cil managed noinlining
    {
        .locals init (valuetype DeclaredGenericStruct`1<int32> V_0)
        ldloca.s V_0
        initobj valuetype DeclaredGenericStruct`1<int32>
        ldloc.0
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetDeclaredGenericStructType<valuetype DeclaredGenericStruct`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredConditionalClass() cil managed noinlining
    {
        newobj instance void class DeclaredConditionalClass`1<int32>::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetDeclaredConditionalClassType<class DeclaredConditionalClass`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredNested() cil managed noinlining
    {
        newobj instance void class DeclaredNestedClass`1<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32>>::.ctor()
        call class [System.Runtime]System.Type IdentityMatrixCalls::GetDeclaredNestedType<class DeclaredNestedClass`1<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericStruct`1<int32>>>(!!0)
        ret
    }

    .method public hidebysig static bool IsDeclaredInterfaceForeignConditionalObjectImplemented() cil managed noinlining
    {
        newobj instance void class [ExtensionInterfaceForeignTypes]ForeignConditionalClass`1<object>::.ctor()
        isinst class IDeclaredConditional`1<object>
        ldnull
        cgt.un
        ret
    }

    .method public hidebysig static bool IsForeignInterfaceDeclaredConditionalObjectImplemented() cil managed noinlining
    {
        newobj instance void class DeclaredConditionalClass`1<object>::.ctor()
        isinst class [ExtensionInterfaceForeignTypes]IForeignConditional`1<object>
        ldnull
        cgt.un
        ret
    }
}

.class interface public abstract auto ansi IDeclaredGenericMethod
{
    .method public hidebysig newslot abstract virtual instance !!TMethod Invoke<TMethod>(!!TMethod) cil managed
    {
    }

    .method public hidebysig newslot abstract virtual instance !!TMethod InvokeConstrained<(IFoo) TMethod>(!!TMethod) cil managed
    {
    }
}

.class interface private abstract auto ansi ForeignGenericMethodClassWitness
    implements IDeclaredGenericMethod
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance !!TMethod Invoke<TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 IDeclaredGenericMethod::Invoke<[1]>(!!0)
        ldarg.0
        castclass [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass
        ldarg.1
        call !!TMethod ForeignGenericMethodClassWitness::InvokeBody<!!TMethod>(class [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeBody<TMethod>(class [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }

    .method private final hidebysig newslot virtual instance !!TMethod InvokeConstrained<(IFoo) TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 IDeclaredGenericMethod::InvokeConstrained<[1]>(!!0)
        ldarg.0
        castclass [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass
        ldarg.1
        call !!TMethod ForeignGenericMethodClassWitness::InvokeConstrainedBody<!!TMethod>(class [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeConstrainedBody<(IFoo) TMethod>(class [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }
}

.class interface private abstract auto ansi ForeignGenericMethodStructWitness
    implements IDeclaredGenericMethod
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance !!TMethod Invoke<TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 IDeclaredGenericMethod::Invoke<[1]>(!!0)
        ldarg.0
        unbox [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct
        ldarg.1
        call !!TMethod ForeignGenericMethodStructWitness::InvokeBody<!!TMethod>(valuetype [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct&, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeBody<TMethod>(valuetype [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct&, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }

    .method private final hidebysig newslot virtual instance !!TMethod InvokeConstrained<(IFoo) TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 IDeclaredGenericMethod::InvokeConstrained<[1]>(!!0)
        ldarg.0
        unbox [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct
        ldarg.1
        call !!TMethod ForeignGenericMethodStructWitness::InvokeConstrainedBody<!!TMethod>(valuetype [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct&, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeConstrainedBody<(IFoo) TMethod>(valuetype [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct&, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }
}

.class public auto ansi beforefieldinit DeclaredGenericMethodClass
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class public sequential ansi sealed beforefieldinit DeclaredGenericMethodStruct
    extends [System.Runtime]System.ValueType
{
    .field public int32 Value
}

.class interface private abstract auto ansi DeclaredGenericMethodClassWitness
    implements [ExtensionInterfaceForeignTypes]IForeignGenericMethod
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance !!TMethod Invoke<TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::Invoke<[1]>(!!0)
        ldarg.0
        castclass DeclaredGenericMethodClass
        ldarg.1
        call !!TMethod DeclaredGenericMethodClassWitness::InvokeBody<!!TMethod>(class DeclaredGenericMethodClass, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeBody<TMethod>(class DeclaredGenericMethodClass, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }

    .method private final hidebysig newslot virtual instance !!TMethod InvokeConstrained<([ExtensionInterfaceForeignTypes]IForeignMethodConstraint) TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::InvokeConstrained<[1]>(!!0)
        ldarg.0
        castclass DeclaredGenericMethodClass
        ldarg.1
        call !!TMethod DeclaredGenericMethodClassWitness::InvokeConstrainedBody<!!TMethod>(class DeclaredGenericMethodClass, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeConstrainedBody<([ExtensionInterfaceForeignTypes]IForeignMethodConstraint) TMethod>(class DeclaredGenericMethodClass, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }
}

.class interface private abstract auto ansi DeclaredGenericMethodStructWitness
    implements [ExtensionInterfaceForeignTypes]IForeignGenericMethod
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance !!TMethod Invoke<TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::Invoke<[1]>(!!0)
        ldarg.0
        unbox DeclaredGenericMethodStruct
        ldarg.1
        call !!TMethod DeclaredGenericMethodStructWitness::InvokeBody<!!TMethod>(valuetype DeclaredGenericMethodStruct&, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeBody<TMethod>(valuetype DeclaredGenericMethodStruct&, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }

    .method private final hidebysig newslot virtual instance !!TMethod InvokeConstrained<([ExtensionInterfaceForeignTypes]IForeignMethodConstraint) TMethod>(!!TMethod) cil managed
    {
        .override method instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::InvokeConstrained<[1]>(!!0)
        ldarg.0
        unbox DeclaredGenericMethodStruct
        ldarg.1
        call !!TMethod DeclaredGenericMethodStructWitness::InvokeConstrainedBody<!!TMethod>(valuetype DeclaredGenericMethodStruct&, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeConstrainedBody<([ExtensionInterfaceForeignTypes]IForeignMethodConstraint) TMethod>(valuetype DeclaredGenericMethodStruct&, !!TMethod) cil managed
    {
        ldarg.1
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit GenericVirtualMethodCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredInterfaceForeignType<(IDeclaredGenericMethod) T>(!!T) cil managed noinlining
    {
        .locals init (string V_0)
        ldarga.s 0
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 IDeclaredGenericMethod::Invoke<int32>(!!0)
        ldc.i4.s 42
        beq.s SHARED
        ldnull
        ret
      SHARED:
        ldstr "shared"
        stloc.0
        ldarga.s 0
        ldloc.0
        constrained. !!T
        callvirt instance !!0 IDeclaredGenericMethod::Invoke<string>(!!0)
        ldloc.0
        ceq
        brtrue.s CONSTRAINED
        ldnull
        ret
      CONSTRAINED:
        ldarga.s 0
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 IDeclaredGenericMethod::InvokeConstrained<int32>(!!0)
        ldc.i4.s 42
        beq.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignInterfaceDeclaredType<([ExtensionInterfaceForeignTypes]IForeignGenericMethod) T>(!!T) cil managed noinlining
    {
        .locals init (class DeclaredMethodArgument V_0, string V_1)
        ldarga.s 0
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::Invoke<int32>(!!0)
        ldc.i4.s 42
        beq.s SHARED
        ldnull
        ret
      SHARED:
        ldstr "shared"
        stloc.1
        ldarga.s 0
        ldloc.1
        constrained. !!T
        callvirt instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::Invoke<string>(!!0)
        ldloc.1
        ceq
        brtrue.s CONSTRAINED
        ldnull
        ret
      CONSTRAINED:
        newobj instance void DeclaredMethodArgument::.ctor()
        stloc.0
        ldarga.s 0
        ldloc.0
        constrained. !!T
        callvirt instance !!0 [ExtensionInterfaceForeignTypes]IForeignGenericMethod::InvokeConstrained<class DeclaredMethodArgument>(!!0)
        ldloc.0
        ceq
        brtrue.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignClass() cil managed noinlining
    {
        newobj instance void [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass::.ctor()
        call class [System.Runtime]System.Type GenericVirtualMethodCalls::GetDeclaredInterfaceForeignType<class [ExtensionInterfaceForeignTypes]ForeignGenericMethodClass>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignStruct() cil managed noinlining
    {
        .locals init (valuetype [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct V_0)
        ldloca.s V_0
        initobj [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct
        ldloc.0
        call class [System.Runtime]System.Type GenericVirtualMethodCalls::GetDeclaredInterfaceForeignType<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericMethodStruct>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredClass() cil managed noinlining
    {
        newobj instance void DeclaredGenericMethodClass::.ctor()
        call class [System.Runtime]System.Type GenericVirtualMethodCalls::GetForeignInterfaceDeclaredType<class DeclaredGenericMethodClass>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredStruct() cil managed noinlining
    {
        .locals init (valuetype DeclaredGenericMethodStruct V_0)
        ldloca.s V_0
        initobj DeclaredGenericMethodStruct
        ldloc.0
        call class [System.Runtime]System.Type GenericVirtualMethodCalls::GetForeignInterfaceDeclaredType<valuetype DeclaredGenericMethodStruct>(!!0)
        ret
    }
}

.class public auto ansi beforefieldinit DeclaredMethodArgument
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi DeclaredMethodArgumentWitness
    implements [ExtensionInterfaceForeignTypes]IForeignMethodConstraint
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )
}

.class interface public abstract auto ansi IDeclaredGenericTypeMethod`1<TContext>
{
    .method public hidebysig newslot abstract virtual instance !!TMethod Invoke<TMethod>(!TContext, !!TMethod) cil managed
    {
    }
}

.class interface private abstract auto ansi ForeignGenericTypeMethodWitness`1<TContext>
    implements class IDeclaredGenericTypeMethod`1<!TContext>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance !!TMethod Invoke<TMethod>(!TContext, !!TMethod) cil managed
    {
        .override method instance !!0 class IDeclaredGenericTypeMethod`1<!TContext>::Invoke<[1]>(!0, !!0)
        ldarg.0
        castclass class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<!TContext>
        ldarg.1
        ldarg.2
        call !!TMethod class ForeignGenericTypeMethodWitness`1<!TContext>::InvokeBody<!!TMethod>(class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<!TContext>, !TContext, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeBody<TMethod>(class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<!TContext>, !TContext, !!TMethod) cil managed
    {
        ldarg.2
        ret
    }
}

.class public auto ansi beforefieldinit DeclaredGenericTypeMethodClass`1<TContext>
    extends [System.Runtime]System.Object
{
    .method public hidebysig specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi DeclaredGenericTypeMethodWitness`1<TContext>
    implements class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<!TContext>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance !!TMethod Invoke<TMethod>(!TContext, !!TMethod) cil managed
    {
        .override method instance !!0 class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<!TContext>::Invoke<[1]>(!0, !!0)
        ldarg.0
        castclass class DeclaredGenericTypeMethodClass`1<!TContext>
        ldarg.1
        ldarg.2
        call !!TMethod class DeclaredGenericTypeMethodWitness`1<!TContext>::InvokeBody<!!TMethod>(class DeclaredGenericTypeMethodClass`1<!TContext>, !TContext, !!TMethod)
        ret
    }

    .method private hidebysig static !!TMethod InvokeBody<TMethod>(class DeclaredGenericTypeMethodClass`1<!TContext>, !TContext, !!TMethod) cil managed
    {
        ldarg.2
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit GenericTypeVirtualMethodCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredInterfaceForeignType<(class IDeclaredGenericTypeMethod`1<int32>) T>(!!T) cil managed noinlining
    {
        .locals init (string V_0)
        ldarga.s 0
        ldc.i4.7
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 class IDeclaredGenericTypeMethod`1<int32>::Invoke<int32>(!0, !!0)
        ldc.i4.s 42
        beq.s SHARED
        ldnull
        ret
      SHARED:
        ldstr "shared"
        stloc.0
        ldarga.s 0
        ldc.i4.7
        ldloc.0
        constrained. !!T
        callvirt instance !!0 class IDeclaredGenericTypeMethod`1<int32>::Invoke<string>(!0, !!0)
        ldloc.0
        ceq
        brtrue.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignInterfaceDeclaredType<(class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<int32>) T>(!!T) cil managed noinlining
    {
        .locals init (string V_0)
        ldarga.s 0
        ldc.i4.7
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<int32>::Invoke<int32>(!0, !!0)
        ldc.i4.s 42
        beq.s SHARED
        ldnull
        ret
      SHARED:
        ldstr "shared"
        stloc.0
        ldarga.s 0
        ldc.i4.7
        ldloc.0
        constrained. !!T
        callvirt instance !!0 class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<int32>::Invoke<string>(!0, !!0)
        ldloc.0
        ceq
        brtrue.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignType() cil managed noinlining
    {
        newobj instance void class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<int32>::.ctor()
        call class [System.Runtime]System.Type GenericTypeVirtualMethodCalls::GetDeclaredInterfaceForeignType<class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<int32>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredType() cil managed noinlining
    {
        newobj instance void class DeclaredGenericTypeMethodClass`1<int32>::.ctor()
        call class [System.Runtime]System.Type GenericTypeVirtualMethodCalls::GetForeignInterfaceDeclaredType<class DeclaredGenericTypeMethodClass`1<int32>>(!!0)
        ret
    }
}

.class interface private abstract auto ansi StringFooWitness
    implements IFoo
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (
        01 00 00 00
    )

    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override IFoo::GetValue
        ldarg.0
        castclass string
        call int32 StringFooWitness::GetValueBody(string)
        ret
    }

    .method private hidebysig static int32 GetValueBody(string) cil managed
    {
        ldc.i4.s 42
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit SharedGenericIdentityCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static class [System.Runtime]System.Type GetType<(IFoo) T>(!!T) cil managed noinlining
    {
        ldarga.s 0
        constrained. !!T
        callvirt instance int32 IFoo::GetValue()
        ldc.i4.s 42
        beq.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunStringType() cil managed noinlining
    {
        ldstr "shared"
        call class [System.Runtime]System.Type SharedGenericIdentityCalls::GetType<string>(!!0)
        ret
    }
}

.class public abstract auto ansi sealed beforefieldinit SharedGenericTypeVirtualMethodCalls
    extends [System.Runtime]System.Object
{
    .method private hidebysig static class [System.Runtime]System.Type GetDeclaredInterfaceForeignType<(class IDeclaredGenericTypeMethod`1<string>) T>(!!T) cil managed noinlining
    {
        .locals init (string V_0, string V_1)
        ldstr "context"
        stloc.0
        ldarga.s 0
        ldloc.0
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 class IDeclaredGenericTypeMethod`1<string>::Invoke<int32>(!0, !!0)
        ldc.i4.s 42
        beq.s SHARED
        ldnull
        ret
      SHARED:
        ldstr "shared"
        stloc.1
        ldarga.s 0
        ldloc.0
        ldloc.1
        constrained. !!T
        callvirt instance !!0 class IDeclaredGenericTypeMethod`1<string>::Invoke<string>(!0, !!0)
        ldloc.1
        ceq
        brtrue.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method private hidebysig static class [System.Runtime]System.Type GetForeignInterfaceDeclaredType<(class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<string>) T>(!!T) cil managed noinlining
    {
        .locals init (string V_0, string V_1)
        ldstr "context"
        stloc.0
        ldarga.s 0
        ldloc.0
        ldc.i4.s 42
        constrained. !!T
        callvirt instance !!0 class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<string>::Invoke<int32>(!0, !!0)
        ldc.i4.s 42
        beq.s SHARED
        ldnull
        ret
      SHARED:
        ldstr "shared"
        stloc.1
        ldarga.s 0
        ldloc.0
        ldloc.1
        constrained. !!T
        callvirt instance !!0 class [ExtensionInterfaceForeignTypes]IForeignGenericTypeMethod`1<string>::Invoke<string>(!0, !!0)
        ldloc.1
        ceq
        brtrue.s IDENTITY
        ldnull
        ret
      IDENTITY:
        ldtoken !!T
        call class [System.Runtime]System.Type [System.Runtime]System.Type::GetTypeFromHandle(valuetype [System.Runtime]System.RuntimeTypeHandle)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunDeclaredInterfaceForeignType() cil managed noinlining
    {
        newobj instance void class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<string>::.ctor()
        call class [System.Runtime]System.Type SharedGenericTypeVirtualMethodCalls::GetDeclaredInterfaceForeignType<class [ExtensionInterfaceForeignTypes]ForeignGenericTypeMethodClass`1<string>>(!!0)
        ret
    }

    .method public hidebysig static class [System.Runtime]System.Type RunForeignInterfaceDeclaredType() cil managed noinlining
    {
        newobj instance void class DeclaredGenericTypeMethodClass`1<string>::.ctor()
        call class [System.Runtime]System.Type SharedGenericTypeVirtualMethodCalls::GetForeignInterfaceDeclaredType<class DeclaredGenericTypeMethodClass`1<string>>(!!0)
        ret
    }
}
