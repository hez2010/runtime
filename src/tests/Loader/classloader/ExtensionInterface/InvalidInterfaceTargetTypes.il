// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly extern System.Collections { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly InvalidInterfaceTargetTypes { }
.module InvalidInterfaceTargetTypes.dll

// Manifest tokens refer to the definitions below. Preserve declaration order.
// IInvalidTarget -> InvalidTargetWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 04 00 00 02 07 00 00 02 02 00 00 00 12 10 02 00 00 00 12 14 01 00 00 00
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

.class interface public abstract auto ansi IInvalidTarget
{
}

.class interface public abstract auto ansi IInvalidContract
{
}

.class public auto ansi InvalidInterfaceTargetProbe extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi InvalidTargetWitness implements IInvalidContract
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

