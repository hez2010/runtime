// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime { }
.assembly extern System.Collections { }
.assembly OpenWitnessTypes { }
.module OpenWitnessTypes.dll

// Each declaration names one open TypeDef. Each member names one Body MethodDef.
// TReceiver : struct, IOpenStorage -> OpenCounterWitness<TReceiver> : IOpenCounter
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    05 00 00 02 // Owner: IOpenCounter
    06 00 00 02 // Implementation: OpenCounterWitness`1
    02 00 00 00 13 00 // Target: VAR 0
    02 00 00 00 12 14 // Contract: IOpenCounter
    02 00 00 00 // InterfaceOwned, no named arguments
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 06 00 00 02 05 00 00 06 08 00 00 06 00 00 // Increment -> IncrementBody
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 06 00 00 02 06 00 00 06 0A 00 00 06 00 00 // Echo<T> -> EchoBody<T>
)
// List<T> -> ListCountWitness<T> : IListCount
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    07 00 00 02 // Owner: IListCount
    08 00 00 02 // Implementation: ListCountWitness`1
    06 00 00 00 15 12 11 01 13 00 // Target: List<VAR 0> (TypeRef 4)
    02 00 00 00 12 1C // Contract: IListCount
    02 00 00 00
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 08 00 00 02 0B 00 00 06 0D 00 00 06 00 00 // Count -> CountBody
)
// Malformed: OpenReceiver<T> has a body specialized to OpenReceiver<int>.
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    0A 00 00 02 // Owner: OpenReceiver`1
    0B 00 00 02 // Implementation: ClosedReceiverWitness`1
    06 00 00 00 15 12 28 01 13 00 // Target: OpenReceiver<VAR 0>
    02 00 00 00 12 24 // Contract: IClosedReceiver
    01 00 00 00
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0B 00 00 02 0E 00 00 06 11 00 00 06 00 00 // Read -> ReadBody
)
// Malformed: the receiver stays open but IClosedMember<T>.Echo(T) is specialized to int.
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    0D 00 00 02 // Owner: ClosedMemberTarget`1
    0E 00 00 02 // Implementation: ClosedMemberWitness`1
    06 00 00 00 15 12 34 01 13 00 // Target: ClosedMemberTarget<VAR 0>
    06 00 00 00 15 12 30 01 13 00 // Contract: IClosedMember<VAR 0>
    01 00 00 00
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 0E 00 00 02 12 00 00 06 15 00 00 06 00 00 // Echo -> EchoBody
)
// Malformed: the specialized body implements an inherited contract member.
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00
    10 00 00 02 // Owner: ClosedBaseTarget`1
    11 00 00 02 // Implementation: ClosedBaseWitness`1
    06 00 00 00 15 12 40 01 13 00 // Target: ClosedBaseTarget<VAR 0>
    06 00 00 00 15 12 3C 01 13 00 // Contract: IClosedChild<VAR 0>
    01 00 00 00
)
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 11 00 00 02 12 00 00 06 18 00 00 06 00 00 // IClosedMember.Echo -> EchoBody
)

.class private auto ansi sealed System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute
    extends [System.Runtime]System.Attribute
{
    .method public specialname rtspecialname instance void .ctor(int32, int32, uint8[], uint8[], uint16) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Attribute::.ctor()
        ret
    }
}

.class private auto ansi sealed System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute
    extends [System.Runtime]System.Attribute
{
    .method public specialname rtspecialname instance void .ctor(int32, int32, int32) cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Attribute::.ctor()
        ret
    }
}

.class interface public abstract auto ansi IOpenStorage
{
    .method public newslot abstract virtual instance int32 Read() cil managed { }
    .method public newslot abstract virtual instance void Write(int32) cil managed { }
}

.class interface public abstract auto ansi IOpenCounter
{
    .method public newslot abstract virtual instance int32 Increment() cil managed { }
    .method public newslot abstract virtual instance !!T[] Echo<T>(!!T[]) cil managed { }
}

.class interface private abstract auto ansi OpenCounterWitness`1<valuetype .ctor ([System.Runtime]System.ValueType, IOpenStorage) TReceiver>
    implements IOpenCounter
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance int32 Increment() cil managed
    {
        .override IOpenCounter::Increment
        ldarg.0
        unbox !TReceiver
        call int32 class OpenCounterWitness`1<!TReceiver>::IncrementBody(!TReceiver&)
        ret
    }

    .method private hidebysig static int32 IncrementBody(!TReceiver&) cil managed
    {
        .locals init (int32 V_0)
        ldarg.0
        constrained. !TReceiver
        callvirt instance int32 IOpenStorage::Read()
        ldc.i4.1
        add
        stloc.0
        ldarg.0
        ldloc.0
        constrained. !TReceiver
        callvirt instance void IOpenStorage::Write(int32)
        ldloc.0
        ret
    }

    .method private final hidebysig newslot virtual instance !!T[] Echo<T>(!!T[]) cil managed
    {
        .override method instance !!0[] IOpenCounter::Echo<[1]>(!!0[])
        ldarg.0
        unbox !TReceiver
        ldarg.1
        call !!T[] class OpenCounterWitness`1<!TReceiver>::EchoBody<!!T>(!TReceiver&, !!T[])
        ret
    }

    .method private hidebysig static !!T[] EchoBody<T>(!TReceiver&, !!T[]) cil managed
    {
        ldarg.0
        call int32 class OpenCounterWitness`1<!TReceiver>::IncrementBody(!TReceiver&)
        pop
        ldarg.1
        ret
    }
}

.class interface public abstract auto ansi IListCount
{
    .method public newslot abstract virtual instance int32 Count() cil managed { }
}

.class interface private abstract auto ansi ListCountWitness`1<T> implements IListCount
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance int32 Count() cil managed
    {
        .override IListCount::Count
        ldarg.0
        castclass class [System.Collections]System.Collections.Generic.List`1<!T>
        call int32 class ListCountWitness`1<!T>::CountBody(class [System.Collections]System.Collections.Generic.List`1<!T>)
        ret
    }

    .method private hidebysig static int32 CountBody(class [System.Collections]System.Collections.Generic.List`1<!T>) cil managed
    {
        ldarg.0
        callvirt instance int32 class [System.Collections]System.Collections.Generic.List`1<!T>::get_Count()
        ret
    }
}

.class interface public abstract auto ansi IClosedReceiver
{
    .method public newslot abstract virtual instance int32 Read() cil managed { }
}

.class public auto ansi OpenReceiver`1<T> extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi ClosedReceiverWitness`1<T> implements IClosedReceiver
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance int32 Read() cil managed
    {
        .override IClosedReceiver::Read
        ldc.i4.0
        ret
    }

    .method private hidebysig static int32 ReadBody(class OpenReceiver`1<int32>) cil managed
    {
        ldc.i4.0
        ret
    }
}

.class interface public abstract auto ansi IClosedMember`1<T>
{
    .method public newslot abstract virtual instance !T Echo(!T) cil managed { }
}

.class public auto ansi ClosedMemberTarget`1<T> extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi ClosedMemberWitness`1<T> implements class IClosedMember`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance !T Echo(!T) cil managed
    {
        .override method instance !0 class IClosedMember`1<!T>::Echo(!0)
        ldarg.1
        ret
    }

    .method private hidebysig static int32 EchoBody(class ClosedMemberTarget`1<!T>, int32) cil managed
    {
        ldarg.1
        ret
    }
}

.class interface public abstract auto ansi IClosedChild`1<T> implements class IClosedMember`1<!T> { }

.class public auto ansi ClosedBaseTarget`1<T> extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }
}

.class interface private abstract auto ansi ClosedBaseWitness`1<T> implements class IClosedChild`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)

    .method private final hidebysig newslot virtual instance !T Echo(!T) cil managed
    {
        .override method instance !0 class IClosedMember`1<!T>::Echo(!0)
        ldarg.1
        ret
    }

    .method private hidebysig static int32 EchoBody(class ClosedBaseTarget`1<!T>, int32) cil managed
    {
        ldarg.1
        ret
    }
}
