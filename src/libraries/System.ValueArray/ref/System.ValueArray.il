// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#include "version.h"

.assembly System.ValueArray
{
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.CompilationRelaxationsAttribute::.ctor(int32) = (
        01 00 08 00 00 00 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.RuntimeCompatibilityAttribute::.ctor() = (
        01 00 01 00 54 02 16 57 72 61 70 4e 6f 6e 45 78
        63 65 70 74 69 6f 6e 54 68 72 6f 77 73 01
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyMetadataAttribute::.ctor(string, string) = (
        01 00 0b 53 65 72 76 69 63 65 61 62 6c 65 04 54
        72 75 65 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyMetadataAttribute::.ctor(string, string) = (
        01 00 0b 50 72 65 66 65 72 49 6e 62 6f 78 04 54
        72 75 65 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyDefaultAliasAttribute::.ctor(string) = (
        01 00 11 53 79 73 74 65 6d 2e 56 61 6c 75 65 41
        72 72 61 79 00 00
    )
	.custom instance void [CORE_ASSEMBLY]System.Resources.NeutralResourcesLanguageAttribute::.ctor(string) = (
		01 00 05 65 6e 2d 55 53 00 00
	)
    .custom instance void [CORE_ASSEMBLY]System.CLSCompliantAttribute::.ctor(bool) = (
        01 00 00 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyMetadataAttribute::.ctor(string, string) = (
        01 00 0b 49 73 54 72 69 6d 6d 61 62 6c 65 05 46
        61 6c 73 65 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyCompanyAttribute::.ctor(string) = (
        01 00 15 4d 69 63 72 6f 73 6f 66 74 20 43 6f 72
        70 6f 72 61 74 69 6f 6e 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyCopyrightAttribute::.ctor(string) = (
        01 00 2e c2 a9 20 4d 69 63 72 6f 73 6f 66 74 20
        43 6f 72 70 6f 72 61 74 69 6f 6e 2e 20 41 6c 6c
        20 72 69 67 68 74 73 20 72 65 73 65 72 76 65 64
        2e 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyDescriptionAttribute::.ctor(string) = (
        01 00 11 53 79 73 74 65 6d 2e 56 61 6c 75 65 41
        72 72 61 79 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyFileVersionAttribute::.ctor(string) = FILE_VERSION
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyInformationalVersionAttribute::.ctor(string) = INFORMATIONAL_VERSION
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyProductAttribute::.ctor(string) = (
        01 00 10 4d 69 63 72 6f 73 6f 66 74 c2 ae 20 2e
        4e 45 54 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyTitleAttribute::.ctor(string) = (
        01 00 11 53 79 73 74 65 6d 2e 56 61 6c 75 65 41
        72 72 61 79 00 00
    )
    .custom instance void [CORE_ASSEMBLY]System.Reflection.AssemblyMetadataAttribute::.ctor(string, string) = (
        01 00 0d 52 65 70 6f 73 69 74 6f 72 79 55 72 6c
        21 68 74 74 70 73 3a 2f 2f 67 69 74 68 75 62 2e
        63 6f 6d 2f 64 6f 74 6e 65 74 2f 72 75 6e 74 69
        6d 65 00 00
    )
    .hash algorithm 0x00008004
    .ver ASSEMBLY_VERSION
}

.module System.ValueArray.dll
.imagebase 0x00400000
.file alignment 0x00000200
.stackreserve 0x00100000
.subsystem 0x0003
.corflags 0x00000001

.class public sequential ansi sealed beforefieldinit System.ValueArray`2<T,literal int32 X>
       extends [CORE_ASSEMBLY]System.ValueType
{
  .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableContextAttribute::.ctor(uint8) = ( 01 00 01 00 00 )
  .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8) = ( 01 00 00 00 00 )
  .custom instance void [CORE_ASSEMBLY]System.Reflection.DefaultMemberAttribute::.ctor(string) = ( 01 00 04 49 74 65 6D 00 00 )                      // ...Item..
  .param type T
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8) = ( 01 00 02 00 00 )
  .param type X
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8) = ( 01 00 02 00 00 )
  .class sequential ansi sealed nested public beforefieldinit Enumerator<T,literal int32 X>
         extends [CORE_ASSEMBLY]System.ValueType
  {
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8) = ( 01 00 00 00 00 )
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.IsByRefLikeAttribute::.ctor() = ( 01 00 00 00 )
    .custom instance void [CORE_ASSEMBLY]System.ObsoleteAttribute::.ctor(string,
                                                                                  bool) = ( 01 00 52 54 79 70 65 73 20 77 69 74 68 20 65 6D   // ..RTypes with em
                                                                                            62 65 64 64 65 64 20 72 65 66 65 72 65 6E 63 65   // bedded reference
                                                                                            73 20 61 72 65 20 6E 6F 74 20 73 75 70 70 6F 72   // s are not suppor
                                                                                            74 65 64 20 69 6E 20 74 68 69 73 20 76 65 72 73   // ted in this vers
                                                                                            69 6F 6E 20 6F 66 20 79 6F 75 72 20 63 6F 6D 70   // ion of your comp
                                                                                            69 6C 65 72 2E 01 00 00 )                         // iler....
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.CompilerFeatureRequiredAttribute::.ctor(string) = ( 01 00 0A 52 65 66 53 74 72 75 63 74 73 00 00 )    // ...RefStructs..
    .param type T
      .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8) = ( 01 00 02 00 00 )
    .param type X
      .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8) = ( 01 00 02 00 00 )
    .method public hidebysig specialname rtspecialname
            instance void  .ctor(valuetype System.ValueArray`2<!T,!X>& 'array') cil managed
    {
      .param [1]
      .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8[]) = ( 01 00 03 00 00 00 00 01 00 00 00 )
      // Code size       15 (0xf)
      .maxstack  8
      ldnull
      throw
    } // end of method Enumerator::.ctor

    .method public hidebysig instance bool
            MoveNext() cil managed
    {
      // Code size       28 (0x1c)
      .maxstack  3
      ldnull
      throw
    } // end of method Enumerator::MoveNext

    .method public hidebysig specialname
            instance !T  get_Current() cil managed
    {
      .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.IsReadOnlyAttribute::.ctor() = ( 01 00 00 00 )
      // Code size       18 (0x12)
      .maxstack  8
      ldnull
      throw
    } // end of method Enumerator::get_Current
  } // end of class Enumerator

  .field private !T _elem
  .method public hidebysig specialname instance !T
          get_Item(int32 index) cil managed
  {
    // Code size       36 (0x24)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::get_Item

  .method public hidebysig specialname instance void
          set_Item(int32 index,
                   !T 'value') cil managed
  {
    // Code size       36 (0x24)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::set_Item

  .method public hidebysig specialname instance int32
          get_Length() cil managed
  {
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.IsReadOnlyAttribute::.ctor() = ( 01 00 00 00 )
    // Code size       6 (0x6)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::get_Length

  .method public hidebysig instance valuetype System.ValueArray`2/Enumerator<!T,!X>
          GetEnumerator() cil managed
  {
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableContextAttribute::.ctor(uint8) = ( 01 00 00 00 00 )
    .custom instance void [CORE_ASSEMBLY]System.Diagnostics.CodeAnalysis.UnscopedRefAttribute::.ctor() = ( 01 00 00 00 )
    // Code size       7 (0x7)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::GetEnumerator

  .method public hidebysig instance void
          CopyTo([in] valuetype System.ValueArray`2<!T,!X>& destination) cil managed
  {
    .param [1]
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.ScopedRefAttribute::.ctor() = ( 01 00 00 00 )
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.RequiresLocationAttribute::.ctor() = ( 01 00 00 00 )
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8[]) = ( 01 00 03 00 00 00 00 01 00 00 00 )
    // Code size       45 (0x2d)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::CopyTo

  .method public hidebysig instance void
          CopyTo(valuetype [CORE_ASSEMBLY]System.Span`1<!T> destination) cil managed
  {
    .param [1]
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8[]) = ( 01 00 02 00 00 00 00 01 00 00 )
    // Code size       57 (0x39)
    .maxstack  3
    ldnull
    throw
  } // end of method ValueArray`2::CopyTo

  .method public hidebysig instance void
          CopyTo(valuetype [CORE_ASSEMBLY]System.Memory`1<!T> destination) cil managed
  {
    .param [1]
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8[]) = ( 01 00 02 00 00 00 00 01 00 00 )
    // Code size       65 (0x41)
    .maxstack  3
    ldnull
    throw
  } // end of method ValueArray`2::CopyTo

  .method public hidebysig instance valuetype [CORE_ASSEMBLY]System.Span`1<!T>
          AsSpan() cil managed
  {
    .param [0]
    .custom instance void [CORE_ASSEMBLY]System.Runtime.CompilerServices.NullableAttribute::.ctor(uint8[]) = ( 01 00 02 00 00 00 00 01 00 00 )
    // Code size       17 (0x11)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::AsSpan

  .method public hidebysig instance void
          CopyTo(!T[] 'array') cil managed
  {
    // Code size       13 (0xd)
    .maxstack  8
    ldnull
    throw
  } // end of method ValueArray`2::CopyTo
} // end of class System.ValueArray`2
