// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

.assembly extern System.Runtime { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly extern System.Collections { .publickeytoken = (B0 3F 5F 7F 11 D5 0A 3A) .ver 11:0:0:0 }
.assembly extern ExtensionInterfaceForeignTypes { }
.assembly extern ResolutionBridgeTypes { }
.assembly ResolutionWitnessTypes { }
.module ResolutionWitnessTypes.dll

// Manifest tokens refer to the definitions below. Preserve declaration order.
// IChainSecond -> ChainSecondWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 04 00 00 02 05 00 00 02 02 00 00 00 12 0D 02 00 00 00 12 10 02 00 00 00
)
// IChainSecond`1 -> ChainSecondWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 06 00 00 02 07 00 00 02 06 00 00 00 15 12 11 01 13 00 06 00 00 00 15 12 18 01 13 00 02 00 00 00
)
// IChainErased -> ErasedTargetWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 08 00 00 02 09 00 00 02 06 00 00 00 15 12 11 01 13 00 02 00 00 00 12 20 02 00 00 00
)
// IDeepResolution96 -> DeepResolutionWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 6A 00 00 02 6B 00 00 02 02 00 00 00 13 00 03 00 00 00 12 81 A8 02 00 00 00
)
// IExpandingResolution`1 -> ExpandingResolutionWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 6C 00 00 02 6E 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 81 B0 01 13 01 02 00 00 00
)
// IExpandingWithWinner`1 -> ExpandingGroundedWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 6D 00 00 02 6F 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 81 B4 01 13 01 02 00 00 00
)
// IExpandingWithWinner`1 -> ExpandingUnfinishedWitness`2
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 6D 00 00 02 70 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 81 B4 01 13 01 02 00 00 00
)
// ReviewSelfTarget -> ReviewSelfWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 72 00 00 02 73 00 00 02 03 00 00 00 12 81 C8 08 00 00 00 15 12 81 C4 01 12 81 C8 01 00 00 00
)
// ReviewGenericSelfTarget`1 -> ReviewGenericSelfWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 74 00 00 02 75 00 00 02 07 00 00 00 15 12 81 D0 01 13 00 0C 00 00 00 15 12 81 C4 01 15 12 81 D0 01 13 00 01 00 00 00
)
// ReviewValueSelfTarget -> ReviewValueSelfWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 76 00 00 02 77 00 00 02 03 00 00 00 11 81 D8 08 00 00 00 15 12 81 C4 01 11 81 D8 01 00 00 00
)
// ReviewConditionalSelfTarget -> ReviewConditionalSelfWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 78 00 00 02 79 00 00 02 03 00 00 00 12 81 E0 07 00 00 00 15 12 81 C4 01 13 00 01 00 00 00
)
// ReviewAmbiguousSelfTarget -> ReviewAmbiguousSelfWitnessA
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 7A 00 00 02 7B 00 00 02 03 00 00 00 12 81 E8 08 00 00 00 15 12 81 C4 01 12 81 E8 01 00 00 00
)
// ReviewAmbiguousSelfTarget -> ReviewAmbiguousSelfWitnessB
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 7A 00 00 02 7C 00 00 02 03 00 00 00 12 81 E8 08 00 00 00 15 12 81 C4 01 12 81 E8 01 00 00 00
)
// ReviewNeedsOtherTarget -> ReviewNeedsOtherWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 7F 00 00 02 80 00 00 02 03 00 00 00 12 81 FC 08 00 00 00 15 12 81 F8 01 12 81 FC 01 00 00 00
)
// IReviewBareSelf`1 -> ReviewBareSelfWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 81 00 00 02 82 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 82 04 01 13 00 02 00 00 00
)
// IReviewReferenceOnly -> IReviewReferenceOnlyWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 83 00 00 02 84 00 00 02 02 00 00 00 13 00 03 00 00 00 12 82 0C 02 00 00 00
)
// IReviewNewOnly -> IReviewNewOnlyWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 85 00 00 02 86 00 00 02 02 00 00 00 13 00 03 00 00 00 12 82 14 02 00 00 00
)
// IReviewSelfCondition -> IReviewSelfConditionWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 87 00 00 02 88 00 00 02 02 00 00 00 13 00 03 00 00 00 12 82 1C 02 00 00 00
)
// IReviewComparableCondition -> IReviewComparableConditionWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 89 00 00 02 8A 00 00 02 02 00 00 00 13 00 03 00 00 00 12 82 24 02 00 00 00
)
// IReviewExactReceiver`1 -> ReviewExactReceiverWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 8B 00 00 02 8C 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 82 2C 01 13 00 02 00 00 00
)
// IReviewCovariantReceiver`1 -> ReviewCovariantReceiverWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 8D 00 00 02 8E 00 00 02 02 00 00 00 13 00 07 00 00 00 15 12 82 34 01 13 00 02 00 00 00
)
// IReviewObjectTarget -> ReviewObjectTargetWitness
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 8F 00 00 02 90 00 00 02 02 00 00 00 12 19 03 00 00 00 12 82 3C 02 00 00 00
)
// IReviewArrayTarget`1 -> ReviewArrayTargetWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 91 00 00 02 92 00 00 02 03 00 00 00 1D 13 00 07 00 00 00 15 12 82 44 01 13 00 02 00 00 00
)
// IReviewFunctionTarget`1 -> ReviewFunctionTargetWitness`1
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceImplAttribute::.ctor(int32, int32, uint8[], uint8[], uint16) = (
    01 00 93 00 00 02 94 00 00 02 06 00 00 00 15 12 2D 01 13 00 07 00 00 00 15 12 82 4C 01 13 00 02 00 00 00
)
// IChainSecond.GetValue -> ChainSecondWitness.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 05 00 00 02 03 00 00 06 05 00 00 06 00 00
)
// IChainSecond`1.GetValue -> ChainSecondWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 07 00 00 02 06 00 00 06 08 00 00 06 00 00
)
// IDeepResolution0.GetValue -> DeepResolutionWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 6B 00 00 02 09 00 00 06 0C 00 00 06 00 00
)
// IDeepResolution96.GetTopValue -> DeepResolutionWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 6B 00 00 02 0A 00 00 06 0C 00 00 06 00 00
)
// IReviewSelf`1.Create -> ReviewSelfWitness.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 73 00 00 02 0E 00 00 06 10 00 00 06 00 00
)
// IReviewSelf`1.Create -> ReviewGenericSelfWitness`1.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 75 00 00 02 0E 00 00 06 12 00 00 06 00 00
)
// IReviewSelf`1.Create -> ReviewValueSelfWitness.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 77 00 00 02 0E 00 00 06 13 00 00 06 00 00
)
// IReviewSelf`1.Create -> ReviewConditionalSelfWitness`1.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 79 00 00 02 0E 00 00 06 15 00 00 06 00 00
)
// IReviewSelf`1.Create -> ReviewAmbiguousSelfWitnessA.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 7B 00 00 02 0E 00 00 06 17 00 00 06 00 00
)
// IReviewSelf`1.Create -> ReviewAmbiguousSelfWitnessB.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 7C 00 00 02 0E 00 00 06 18 00 00 06 00 00
)
// IReviewBareSelf`1.Create -> ReviewBareSelfWitness`1.CreateBody
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 82 00 00 02 1A 00 00 06 1B 00 00 06 00 00
)
// IReviewArrayTarget`1.GetValue -> ReviewArrayTargetWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 92 00 00 02 1C 00 00 06 1E 00 00 06 00 00
)
// IReviewFunctionTarget`1.GetValue -> ReviewFunctionTargetWitness`1.Body
.custom instance void System.Runtime.CompilerServices.ExtensionInterfaceMethodImplAttribute::.ctor(int32, int32, int32) = (
    01 00 94 00 00 02 1F 00 00 06 21 00 00 06 00 00
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

.class interface public abstract auto ansi IChainSecond
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi ChainSecondWitness implements IChainSecond
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 IChainSecond::GetValue()
        ldarg.0
        castclass class [ResolutionBridgeTypes]IChainFirst
        call int32 ChainSecondWitness::Body(class [ResolutionBridgeTypes]IChainFirst)
        ret
    }

    .method private hidebysig static int32 Body(class [ResolutionBridgeTypes]IChainFirst) cil managed
    {
        ldarg.0
        callvirt instance int32 class [ResolutionBridgeTypes]IChainFirst::GetValue()
        ret
    }

}

.class interface public abstract auto ansi IChainSecond`1<T>
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi ChainSecondWitness`1<T> implements class IChainSecond`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 class IChainSecond`1<!T>::GetValue()
        ldarg.0
        castclass class [ResolutionBridgeTypes]IChainFirst`1<!T>
        call int32 class ChainSecondWitness`1<!T>::Body(class [ResolutionBridgeTypes]IChainFirst`1<!T>)
        ret
    }

    .method private hidebysig static int32 Body(class [ResolutionBridgeTypes]IChainFirst`1<!T>) cil managed
    {
        ldarg.0
        callvirt instance int32 class [ResolutionBridgeTypes]IChainFirst`1<!T>::GetValue()
        ret
    }

}

.class interface public abstract auto ansi IChainErased
{
}

.class interface public abstract auto ansi ErasedTargetWitness`1<T> implements IChainErased
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IDeepResolution0
{
    .method public hidebysig newslot abstract virtual instance int32 GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi IDeepResolution1 implements IDeepResolution0
{
}

.class interface public abstract auto ansi IDeepResolution2 implements IDeepResolution1
{
}

.class interface public abstract auto ansi IDeepResolution3 implements IDeepResolution2
{
}

.class interface public abstract auto ansi IDeepResolution4 implements IDeepResolution3
{
}

.class interface public abstract auto ansi IDeepResolution5 implements IDeepResolution4
{
}

.class interface public abstract auto ansi IDeepResolution6 implements IDeepResolution5
{
}

.class interface public abstract auto ansi IDeepResolution7 implements IDeepResolution6
{
}

.class interface public abstract auto ansi IDeepResolution8 implements IDeepResolution7
{
}

.class interface public abstract auto ansi IDeepResolution9 implements IDeepResolution8
{
}

.class interface public abstract auto ansi IDeepResolution10 implements IDeepResolution9
{
}

.class interface public abstract auto ansi IDeepResolution11 implements IDeepResolution10
{
}

.class interface public abstract auto ansi IDeepResolution12 implements IDeepResolution11
{
}

.class interface public abstract auto ansi IDeepResolution13 implements IDeepResolution12
{
}

.class interface public abstract auto ansi IDeepResolution14 implements IDeepResolution13
{
}

.class interface public abstract auto ansi IDeepResolution15 implements IDeepResolution14
{
}

.class interface public abstract auto ansi IDeepResolution16 implements IDeepResolution15
{
}

.class interface public abstract auto ansi IDeepResolution17 implements IDeepResolution16
{
}

.class interface public abstract auto ansi IDeepResolution18 implements IDeepResolution17
{
}

.class interface public abstract auto ansi IDeepResolution19 implements IDeepResolution18
{
}

.class interface public abstract auto ansi IDeepResolution20 implements IDeepResolution19
{
}

.class interface public abstract auto ansi IDeepResolution21 implements IDeepResolution20
{
}

.class interface public abstract auto ansi IDeepResolution22 implements IDeepResolution21
{
}

.class interface public abstract auto ansi IDeepResolution23 implements IDeepResolution22
{
}

.class interface public abstract auto ansi IDeepResolution24 implements IDeepResolution23
{
}

.class interface public abstract auto ansi IDeepResolution25 implements IDeepResolution24
{
}

.class interface public abstract auto ansi IDeepResolution26 implements IDeepResolution25
{
}

.class interface public abstract auto ansi IDeepResolution27 implements IDeepResolution26
{
}

.class interface public abstract auto ansi IDeepResolution28 implements IDeepResolution27
{
}

.class interface public abstract auto ansi IDeepResolution29 implements IDeepResolution28
{
}

.class interface public abstract auto ansi IDeepResolution30 implements IDeepResolution29
{
}

.class interface public abstract auto ansi IDeepResolution31 implements IDeepResolution30
{
}

.class interface public abstract auto ansi IDeepResolution32 implements IDeepResolution31
{
}

.class interface public abstract auto ansi IDeepResolution33 implements IDeepResolution32
{
}

.class interface public abstract auto ansi IDeepResolution34 implements IDeepResolution33
{
}

.class interface public abstract auto ansi IDeepResolution35 implements IDeepResolution34
{
}

.class interface public abstract auto ansi IDeepResolution36 implements IDeepResolution35
{
}

.class interface public abstract auto ansi IDeepResolution37 implements IDeepResolution36
{
}

.class interface public abstract auto ansi IDeepResolution38 implements IDeepResolution37
{
}

.class interface public abstract auto ansi IDeepResolution39 implements IDeepResolution38
{
}

.class interface public abstract auto ansi IDeepResolution40 implements IDeepResolution39
{
}

.class interface public abstract auto ansi IDeepResolution41 implements IDeepResolution40
{
}

.class interface public abstract auto ansi IDeepResolution42 implements IDeepResolution41
{
}

.class interface public abstract auto ansi IDeepResolution43 implements IDeepResolution42
{
}

.class interface public abstract auto ansi IDeepResolution44 implements IDeepResolution43
{
}

.class interface public abstract auto ansi IDeepResolution45 implements IDeepResolution44
{
}

.class interface public abstract auto ansi IDeepResolution46 implements IDeepResolution45
{
}

.class interface public abstract auto ansi IDeepResolution47 implements IDeepResolution46
{
}

.class interface public abstract auto ansi IDeepResolution48 implements IDeepResolution47
{
}

.class interface public abstract auto ansi IDeepResolution49 implements IDeepResolution48
{
}

.class interface public abstract auto ansi IDeepResolution50 implements IDeepResolution49
{
}

.class interface public abstract auto ansi IDeepResolution51 implements IDeepResolution50
{
}

.class interface public abstract auto ansi IDeepResolution52 implements IDeepResolution51
{
}

.class interface public abstract auto ansi IDeepResolution53 implements IDeepResolution52
{
}

.class interface public abstract auto ansi IDeepResolution54 implements IDeepResolution53
{
}

.class interface public abstract auto ansi IDeepResolution55 implements IDeepResolution54
{
}

.class interface public abstract auto ansi IDeepResolution56 implements IDeepResolution55
{
}

.class interface public abstract auto ansi IDeepResolution57 implements IDeepResolution56
{
}

.class interface public abstract auto ansi IDeepResolution58 implements IDeepResolution57
{
}

.class interface public abstract auto ansi IDeepResolution59 implements IDeepResolution58
{
}

.class interface public abstract auto ansi IDeepResolution60 implements IDeepResolution59
{
}

.class interface public abstract auto ansi IDeepResolution61 implements IDeepResolution60
{
}

.class interface public abstract auto ansi IDeepResolution62 implements IDeepResolution61
{
}

.class interface public abstract auto ansi IDeepResolution63 implements IDeepResolution62
{
}

.class interface public abstract auto ansi IDeepResolution64 implements IDeepResolution63
{
}

.class interface public abstract auto ansi IDeepResolution65 implements IDeepResolution64
{
}

.class interface public abstract auto ansi IDeepResolution66 implements IDeepResolution65
{
}

.class interface public abstract auto ansi IDeepResolution67 implements IDeepResolution66
{
}

.class interface public abstract auto ansi IDeepResolution68 implements IDeepResolution67
{
}

.class interface public abstract auto ansi IDeepResolution69 implements IDeepResolution68
{
}

.class interface public abstract auto ansi IDeepResolution70 implements IDeepResolution69
{
}

.class interface public abstract auto ansi IDeepResolution71 implements IDeepResolution70
{
}

.class interface public abstract auto ansi IDeepResolution72 implements IDeepResolution71
{
}

.class interface public abstract auto ansi IDeepResolution73 implements IDeepResolution72
{
}

.class interface public abstract auto ansi IDeepResolution74 implements IDeepResolution73
{
}

.class interface public abstract auto ansi IDeepResolution75 implements IDeepResolution74
{
}

.class interface public abstract auto ansi IDeepResolution76 implements IDeepResolution75
{
}

.class interface public abstract auto ansi IDeepResolution77 implements IDeepResolution76
{
}

.class interface public abstract auto ansi IDeepResolution78 implements IDeepResolution77
{
}

.class interface public abstract auto ansi IDeepResolution79 implements IDeepResolution78
{
}

.class interface public abstract auto ansi IDeepResolution80 implements IDeepResolution79
{
}

.class interface public abstract auto ansi IDeepResolution81 implements IDeepResolution80
{
}

.class interface public abstract auto ansi IDeepResolution82 implements IDeepResolution81
{
}

.class interface public abstract auto ansi IDeepResolution83 implements IDeepResolution82
{
}

.class interface public abstract auto ansi IDeepResolution84 implements IDeepResolution83
{
}

.class interface public abstract auto ansi IDeepResolution85 implements IDeepResolution84
{
}

.class interface public abstract auto ansi IDeepResolution86 implements IDeepResolution85
{
}

.class interface public abstract auto ansi IDeepResolution87 implements IDeepResolution86
{
}

.class interface public abstract auto ansi IDeepResolution88 implements IDeepResolution87
{
}

.class interface public abstract auto ansi IDeepResolution89 implements IDeepResolution88
{
}

.class interface public abstract auto ansi IDeepResolution90 implements IDeepResolution89
{
}

.class interface public abstract auto ansi IDeepResolution91 implements IDeepResolution90
{
}

.class interface public abstract auto ansi IDeepResolution92 implements IDeepResolution91
{
}

.class interface public abstract auto ansi IDeepResolution93 implements IDeepResolution92
{
}

.class interface public abstract auto ansi IDeepResolution94 implements IDeepResolution93
{
}

.class interface public abstract auto ansi IDeepResolution95 implements IDeepResolution94
{
}

.class interface public abstract auto ansi IDeepResolution96 implements IDeepResolution95
{
    .method public hidebysig newslot abstract virtual instance int32 GetTopValue() cil managed
    {
    }

}

.class interface public abstract auto ansi DeepResolutionWitness`1<class T> implements IDeepResolution96
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance int32 GetValue() cil managed
    {
        .override method instance int32 IDeepResolution0::GetValue()
        ldarg.0
        castclass !T
        call int32 class DeepResolutionWitness`1<!T>::Body(!T)
        ret
    }

    .method private hidebysig static int32 Body(!T) cil managed
    {
        ldc.i4.s 96
        ret
    }

    .method private final hidebysig newslot virtual instance int32 GetTopValue() cil managed
    {
        .override IDeepResolution96::GetTopValue
        ldarg.0
        castclass !T
        call int32 class DeepResolutionWitness`1<!T>::Body(!T)
        ret
    }

}

.class interface public abstract auto ansi IExpandingResolution`1<T>
{
}

.class interface public abstract auto ansi IExpandingWithWinner`1<T>
{
}

.class interface public abstract auto ansi ExpandingResolutionWitness`2<class (class IExpandingResolution`1<class [System.Collections]System.Collections.Generic.List`1<!T>>) TReceiver, T> implements class IExpandingResolution`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi ExpandingGroundedWitness`2<class TReceiver, T> implements class IExpandingWithWinner`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi ExpandingUnfinishedWitness`2<class (class IExpandingResolution`1<!T>) TReceiver, T> implements class IExpandingWithWinner`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewSelf`1<(class IReviewSelf`1<!TSelf>) TSelf>
{
    .method public hidebysig newslot abstract virtual static !TSelf Create() cil managed
    {
    }

}

.class public auto ansi ReviewSelfTarget extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi ReviewSelfWitness implements class IReviewSelf`1<class ReviewSelfTarget>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static class ReviewSelfTarget CreateBody() cil managed
    {
        .override method !0 class IReviewSelf`1<class ReviewSelfTarget>::Create()
        newobj instance void class ReviewSelfTarget::.ctor()
        ret
    }

}

.class public auto ansi ReviewGenericSelfTarget`1<T> extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi ReviewGenericSelfWitness`1<T> implements class IReviewSelf`1<class ReviewGenericSelfTarget`1<!T>>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static class ReviewGenericSelfTarget`1<!T> CreateBody() cil managed
    {
        .override method !0 class IReviewSelf`1<class ReviewGenericSelfTarget`1<!T>>::Create()
        newobj instance void class ReviewGenericSelfTarget`1<!T>::.ctor()
        ret
    }

}

.class public auto ansi sealed ReviewValueSelfTarget extends [System.Runtime]System.ValueType
{
}

.class interface public abstract auto ansi ReviewValueSelfWitness implements class IReviewSelf`1<valuetype ReviewValueSelfTarget>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static valuetype ReviewValueSelfTarget CreateBody() cil managed
    {
        .override method !0 class IReviewSelf`1<valuetype ReviewValueSelfTarget>::Create()
        .locals init (valuetype ReviewValueSelfTarget V_0)
        ldloc.0
        ret
    }

}

.class public auto ansi ReviewConditionalSelfTarget extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi ReviewConditionalSelfWitness`1<(class IReviewSelf`1<!T>) T> implements class IReviewSelf`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static !T CreateBody() cil managed
    {
        .override method !0 class IReviewSelf`1<!T>::Create()
        ldnull
        ret
    }

}

.class public auto ansi ReviewAmbiguousSelfTarget extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi ReviewAmbiguousSelfWitnessA implements class IReviewSelf`1<class ReviewAmbiguousSelfTarget>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static class ReviewAmbiguousSelfTarget CreateBody() cil managed
    {
        .override method !0 class IReviewSelf`1<class ReviewAmbiguousSelfTarget>::Create()
        newobj instance void class ReviewAmbiguousSelfTarget::.ctor()
        ret
    }

}

.class interface public abstract auto ansi ReviewAmbiguousSelfWitnessB implements class IReviewSelf`1<class ReviewAmbiguousSelfTarget>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static class ReviewAmbiguousSelfTarget CreateBody() cil managed
    {
        .override method !0 class IReviewSelf`1<class ReviewAmbiguousSelfTarget>::Create()
        newobj instance void class ReviewAmbiguousSelfTarget::.ctor()
        ret
    }

}

.class interface public abstract auto ansi IReviewOther`1<T>
{
}

.class interface public abstract auto ansi IReviewNeedsOther`1<(class IReviewNeedsOther`1<!T>, class IReviewOther`1<!T>) T>
{
}

.class public auto ansi ReviewNeedsOtherTarget extends [System.Runtime]System.Object
{
    .method public specialname rtspecialname instance void .ctor() cil managed
    {
        ldarg.0
        call instance void [System.Runtime]System.Object::.ctor()
        ret
    }

}

.class interface public abstract auto ansi ReviewNeedsOtherWitness implements class IReviewNeedsOther`1<class ReviewNeedsOtherTarget>, class IReviewOther`1<class ReviewNeedsOtherTarget>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewBareSelf`1<(class IReviewBareSelf`1<!TSelf>) TSelf>
{
    .method public hidebysig newslot abstract virtual static !TSelf Create() cil managed
    {
    }

}

.class interface public abstract auto ansi ReviewBareSelfWitness`1<class .ctor T> implements class IReviewBareSelf`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private hidebysig static !T CreateBody() cil managed
    {
        .override method !0 class IReviewBareSelf`1<!T>::Create()
        call !!0 [System.Runtime]System.Activator::CreateInstance<!T>()
        ret
    }

}

.class interface public abstract auto ansi IReviewReferenceOnly
{
}

.class interface public abstract auto ansi IReviewReferenceOnlyWitness`1<class T> implements IReviewReferenceOnly
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewNewOnly
{
}

.class interface public abstract auto ansi IReviewNewOnlyWitness`1<class .ctor T> implements IReviewNewOnly
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewSelfCondition
{
}

.class interface public abstract auto ansi IReviewSelfConditionWitness`1<class (class [System.Runtime]System.IEquatable`1<!T>) T> implements IReviewSelfCondition
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewComparableCondition
{
}

.class interface public abstract auto ansi IReviewComparableConditionWitness`1<class (class [System.Runtime]System.IComparable`1<!T>) T> implements IReviewComparableCondition
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewExactReceiver`1<T>
{
}

.class interface public abstract auto ansi ReviewExactReceiverWitness`1<class T> implements class IReviewExactReceiver`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewCovariantReceiver`1<+T>
{
}

.class interface public abstract auto ansi ReviewCovariantReceiverWitness`1<class T> implements class IReviewCovariantReceiver`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewObjectTarget
{
}

.class interface public abstract auto ansi ReviewObjectTargetWitness implements IReviewObjectTarget
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
}

.class interface public abstract auto ansi IReviewArrayTarget`1<T>
{
    .method public hidebysig newslot abstract virtual instance !T GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi ReviewArrayTargetWitness`1<T> implements class IReviewArrayTarget`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance !T GetValue() cil managed
    {
        .override method instance !T class IReviewArrayTarget`1<!T>::GetValue()
        ldarg.0
        castclass !T[]
        call !T class ReviewArrayTargetWitness`1<!T>::Body(!T[])
        ret
    }

    .method private hidebysig static !T Body(!T[]) cil managed
    {
        ldarg.0
        ldc.i4.0
        ldelem !T
        ret
    }

}

.class interface public abstract auto ansi IReviewFunctionTarget`1<T>
{
    .method public hidebysig newslot abstract virtual instance !T GetValue() cil managed
    {
    }

}

.class interface public abstract auto ansi ReviewFunctionTargetWitness`1<T> implements class IReviewFunctionTarget`1<!T>
{
    .custom instance void [System.Runtime]System.Runtime.CompilerServices.ExtensionInterfaceImplementationAttribute::.ctor() = (01 00 00 00)
    .method private final hidebysig newslot virtual instance !T GetValue() cil managed
    {
        .override method instance !T class IReviewFunctionTarget`1<!T>::GetValue()
        ldarg.0
        castclass class [System.Runtime]System.Func`1<!T>
        call !T class ReviewFunctionTargetWitness`1<!T>::Body(class [System.Runtime]System.Func`1<!T>)
        ret
    }

    .method private hidebysig static !T Body(class [System.Runtime]System.Func`1<!T>) cil managed
    {
        ldarg.0
        callvirt instance !0 class [System.Runtime]System.Func`1<!T>::Invoke()
        ret
    }

}

.class public abstract sealed auto ansi ResolutionCalls extends [System.Runtime]System.Object
{
    .method public hidebysig static int32 UseSecond<(IChainSecond) T>(!!T) cil managed noinlining
    {
        ldarga.s 0
        constrained. !!T
        callvirt instance int32 IChainSecond::GetValue()
        ret
    }

    .method public hidebysig static int32 ThroughFirst(object) cil managed noinlining
    {
        ldarg.0
        castclass [ResolutionBridgeTypes]IChainFirst
        call int32 ResolutionCalls::UseSecond<class [ResolutionBridgeTypes]IChainFirst>(!!0)
        ret
    }

    .method public hidebysig static int32 ValueChain() cil managed noinlining
    {
        .locals init (valuetype [ExtensionInterfaceForeignTypes]ForeignChainValue V_0)
        ldloc.0
        call int32 ResolutionCalls::UseSecond<valuetype [ExtensionInterfaceForeignTypes]ForeignChainValue>(!!0)
        ret
    }

    .method public hidebysig static int32 GenericValueChain<T>() cil managed noinlining
    {
        .locals init (valuetype [ExtensionInterfaceForeignTypes]ForeignGenericChainValue`1<!!T> V_0)
        ldloc.0
        call int32 ResolutionCalls::UseSecond<valuetype [ExtensionInterfaceForeignTypes]ForeignGenericChainValue`1<!!T>>(!!0)
        ret
    }

    .method public hidebysig static int32 GenericChain<T>(object) cil managed noinlining
    {
        ldarg.0
        castclass class IChainSecond`1<!!T>
        callvirt instance int32 class IChainSecond`1<!!T>::GetValue()
        ret
    }

    .method public hidebysig static object CreateSelf<(class IReviewSelf`1<!!T>) T>() cil managed noinlining
    {
        constrained. !!T
        call !0 class IReviewSelf`1<!!T>::Create()
        box !!T
        ret
    }

    .method public hidebysig static object CreateGenericSelf<T>() cil managed noinlining
    {
        call object ResolutionCalls::CreateSelf<class ReviewGenericSelfTarget`1<!!T>>()
        ret
    }

    .method public hidebysig static object CreateBareSelf<(class IReviewBareSelf`1<!!T>) T>() cil managed noinlining
    {
        constrained. !!T
        call !0 class IReviewBareSelf`1<!!T>::Create()
        box !!T
        ret
    }

    .method public hidebysig static object CreateConditionalSelf() cil managed noinlining
    {
        call object ResolutionCalls::CreateSelf<class ReviewConditionalSelfTarget>()
        ret
    }

    .method public hidebysig static object CreateAmbiguousSelf() cil managed noinlining
    {
        call object ResolutionCalls::CreateSelf<class ReviewAmbiguousSelfTarget>()
        ret
    }

}

