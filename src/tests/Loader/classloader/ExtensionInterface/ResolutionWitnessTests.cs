// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Threading.Tasks;

public static partial class ExtensionInterfaceTests
{
    private static void RunResolutionReviewCase(string name)
    {
        Console.WriteLine(name);
        switch (name)
        {
            case "interface-targets": InterfaceTargetsPreserveSubstitution(); break;
            case "deep-owner": DeepInterfaceOwnersRemainDiscoverable(); break;
            case "self-contracts": ContractSelfReferencesDoNotJustifyApplicability(); break;
            case "resolution-limit": ExpandingResolutionDoesNotPublishAnAnswer(); break;
            default: throw new ArgumentException(name);
        }
    }

    private static void InterfaceTargetsPreserveSubstitution()
    {
        object receiver = new ForeignChainReceiver();
        Assert.False(typeof(ForeignChainReceiver).Assembly == typeof(IChainFirst).Assembly);
        Assert.False(typeof(IChainFirst).Assembly == typeof(IChainSecond).Assembly);
        Assert.True(typeof(IChainSecond).IsAssignableFrom(typeof(IChainFirst)));
        Assert.True(typeof(IChainSecond).IsAssignableFrom(typeof(ForeignChainReceiver)));
        IChainFirst first = (IChainFirst)receiver;
        IChainSecond second = (IChainSecond)(object)first;
        Assert.Same(receiver, second);
        Assert.Equal(71, second.GetValue());
        Assert.Equal(71, ResolutionCalls.ThroughFirst(receiver));
        Assert.Equal(71, ResolutionCalls.GenericChain<int>(receiver));
        Assert.Equal(71, ResolutionCalls.GenericChain<string>(receiver));
        Func<int> call = second.GetValue;
        Assert.Equal(71, call());
        Assert.Equal("ChainSecondWitness",
            typeof(ForeignChainReceiver).GetInterfaceMap(typeof(IChainSecond)).TargetMethods[0].DeclaringType!.Name);
        Assert.DoesNotContain(typeof(IChainFirst), typeof(ForeignChainReceiver).GetInterfaces());
        Assert.DoesNotContain(typeof(IChainSecond), typeof(ForeignChainReceiver).GetInterfaces());

        object boxed = new ForeignChainValue();
        Assert.Equal(71, ((IChainSecond)boxed).GetValue());
        Assert.Same(boxed, (IChainSecond)boxed);
        Assert.Equal(71, ResolutionCalls.ValueChain());
        Assert.Equal(71, ResolutionCalls.GenericValueChain<int>());
        Assert.Equal(71, ResolutionCalls.GenericValueChain<string>());
        Assert.Equal(71, ResolutionCalls.GenericValueChain<object>());
        Assert.Equal(71, InvokeSecond(new ForeignGenericChainValue<string>()));
        Assert.Equal(71, InvokeSecond(new ForeignGenericChainValue<object>()));
        Assert.Equal(83, ((IChainSecond)(object)new NominalChainFirst()).GetValue());
        Assert.Equal(91, ((IChainSecond)new NominalChainSecond()).GetValue());
        Assert.False(typeof(IChainSecond).IsAssignableFrom(typeof(object)));
        Assert.False(typeof(IChainErased).IsAssignableFrom(typeof(IChainFirst<int>)));
        Assert.False(typeof(IChainErased).IsAssignableFrom(typeof(ForeignChainReceiver)));
        Assert.False(typeof(IListInference).IsAssignableFrom(typeof(IList<int>)));
        Assert.True(typeof(IListInference).IsAssignableFrom(typeof(List<int>)));
        Assert.True(typeof(IListInference).IsAssignableFrom(typeof(DerivedInferenceList)));
        Assert.True(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(OpenReferenceReceiver)));
        Assert.True(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(DerivedWithoutDefaultConstructor)));
        Assert.False(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(object)));
        Assert.False(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(ValueType)));
        Assert.False(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(Enum)));
        Assert.False(typeof(IReviewNewOnly).IsAssignableFrom(typeof(OpenReferenceReceiver)));
        Assert.False(typeof(IReviewNewOnly).IsAssignableFrom(typeof(DerivedWithoutDefaultConstructor)));
        Assert.True(typeof(IReviewNewOnly).IsAssignableFrom(typeof(ForeignChainReceiver)));
        Assert.False(typeof(IReviewExactReceiver<OpenReferenceReceiver>).IsAssignableFrom(typeof(OpenReferenceReceiver)));
        Assert.True(typeof(IReviewExactReceiver<ForeignChainReceiver>).IsAssignableFrom(typeof(ForeignChainReceiver)));
        Assert.False(typeof(IReviewSelfCondition).IsAssignableFrom(typeof(OpenEquatableReceiver)));
        Assert.True(typeof(IReviewSelfCondition).IsAssignableFrom(typeof(SealedEquatableReceiver)));
        Assert.True(typeof(IReviewComparableCondition).IsAssignableFrom(typeof(OpenComparableReceiver)));
        Assert.True(typeof(IReviewComparableCondition).IsAssignableFrom(typeof(DerivedComparableReceiver)));
        Assert.True(typeof(IReviewCovariantReceiver<OpenReferenceReceiver>).IsAssignableFrom(typeof(OpenReferenceReceiver)));
        Assert.True(typeof(IReviewCovariantReceiver<OpenReferenceReceiver>).IsAssignableFrom(typeof(DerivedWithoutDefaultConstructor)));
        Assert.True(typeof(IReviewObjectTarget).IsAssignableFrom(typeof(object)));
        Assert.True(typeof(IReviewObjectTarget).IsAssignableFrom(typeof(ForeignChainValue)));
        Assert.True(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(object[])));
        Assert.True(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(string[])));
        Assert.True(typeof(IReviewReferenceOnly).IsAssignableFrom(typeof(Func<object>)));
        Assert.False(typeof(IReviewExactReceiver<object[]>).IsAssignableFrom(typeof(object[])));
        Assert.False(typeof(IReviewExactReceiver<Func<object>>).IsAssignableFrom(typeof(Func<object>)));
        Assert.False(typeof(IListInference).IsAssignableFrom(typeof(object[])));
        object array = new string[] { "array" };
        for (int i = 0; i < 2; i++)
            Assert.True(typeof(IReviewArrayTarget<object>).IsAssignableFrom(typeof(string[])));
        Assert.Equal("array", (string)((IReviewArrayTarget<object>)array).GetValue());
        Assert.Same(array, (IReviewArrayTarget<object>)array);
        Assert.Equal(37, ((IReviewArrayTarget<int>)(object)new int[] { 37 }).GetValue());
        object function = (Func<string>)(() => "function");
        Assert.Equal("function", (string)((IReviewFunctionTarget<object>)function).GetValue());
        Assert.Same(function, (IReviewFunctionTarget<object>)function);
        Assert.False(typeof(IReviewFunctionTarget<int>).IsAssignableFrom(typeof(Func<string>)));
        Parallel.For(0, 32, _ => Assert.Equal(71, ResolutionCalls.GenericChain<string>(new ForeignChainReceiver())));

        // An interface target must be owned by the resulting contract, even
        // when the target interface and its witness share a module.
        Assert.Throws<TypeLoadException>(() => Assembly.Load("InvalidInterfaceTargetTypes")
            .GetType("InvalidInterfaceTargetProbe", throwOnError: true));
    }

    private static void DeepInterfaceOwnersRemainDiscoverable()
    {
        object receiver = new ForeignChainReceiver();
        Assert.True(typeof(IDeepResolution0).IsAssignableFrom(typeof(ForeignChainReceiver)));
        Assert.Equal(96, ((IDeepResolution0)receiver).GetValue());
        Assert.True(receiver is IDeepResolution96);
        Assert.Equal(96, ((IDeepResolution96)receiver).GetTopValue());
        Assert.Equal(typeof(ForeignChainReceiver).GetInterfaceMap(typeof(IDeepResolution0)).TargetMethods[0].DeclaringType,
            typeof(ForeignChainReceiver).GetInterfaceMap(typeof(IDeepResolution96)).TargetMethods[0].DeclaringType);
    }

    private static int InvokeSecond<T>(T value) => typeof(ResolutionCalls).GetMethod(nameof(ResolutionCalls.UseSecond))!
        .MakeGenericMethod(typeof(T)).CreateDelegate<Func<T, int>>()(value);

    private static void ContractSelfReferencesDoNotJustifyApplicability()
    {
        Type contract = typeof(IReviewSelf<>).MakeGenericType(typeof(ReviewSelfTarget));
        Assert.True(contract.IsAssignableFrom(typeof(ReviewSelfTarget)));
        Assert.Equal(typeof(ReviewSelfTarget), CreateReviewSelf(typeof(ReviewSelfTarget)).GetType());
        Assert.Equal(typeof(ReviewValueSelfTarget), CreateReviewSelf(typeof(ReviewValueSelfTarget)).GetType());
        Assert.Equal(typeof(ReviewGenericSelfTarget<int>), CreateReviewSelf(typeof(ReviewGenericSelfTarget<int>)).GetType());
        Assert.Equal(typeof(ReviewGenericSelfTarget<string>), CreateReviewSelf(typeof(ReviewGenericSelfTarget<string>)).GetType());
        Assert.Equal(typeof(ReviewGenericSelfTarget<int>), ResolutionCalls.CreateGenericSelf<int>().GetType());
        Assert.Equal(typeof(ReviewGenericSelfTarget<string>), ResolutionCalls.CreateGenericSelf<string>().GetType());
        object bare = typeof(ResolutionCalls).GetMethod(nameof(ResolutionCalls.CreateBareSelf))!
            .MakeGenericMethod(typeof(ForeignChainReceiver)).CreateDelegate<Func<object>>()();
        Assert.Equal(typeof(ForeignChainReceiver), bare.GetType());
        for (int i = 0; i < 2; i++)
        {
            Assert.Throws<System.Security.VerificationException>(() => ResolutionCalls.CreateConditionalSelf());
            Assert.Throws<TypeLoadException>(() => ResolutionCalls.CreateAmbiguousSelf());
            Assert.Throws<ArgumentException>(() => typeof(IReviewNeedsOther<>).MakeGenericType(typeof(ReviewNeedsOtherTarget)));
        }
        // Failed conditional and ambiguous contracts cannot contaminate a
        // separately established implementation's validation.
        Assert.Equal(typeof(ReviewSelfTarget), CreateReviewSelf(typeof(ReviewSelfTarget)).GetType());
    }

    private static object CreateReviewSelf(Type receiver) => typeof(ResolutionCalls).GetMethod(nameof(ResolutionCalls.CreateSelf))!
        .MakeGenericMethod(receiver).CreateDelegate<Func<object>>()();

    private static void ExpandingResolutionDoesNotPublishAnAnswer()
    {
        for (int i = 0; i < 2; i++)
        {
            AssertResolutionLimit(() => typeof(IExpandingResolution<int>).IsAssignableFrom(typeof(ForeignChainReceiver)));
            // A known candidate does not establish uniqueness while another
            // candidate's obligations could not be completed.
            AssertResolutionLimit(() => typeof(IExpandingWithWinner<string>).IsAssignableFrom(typeof(ForeignChainReceiver)));
        }
        Assert.True(typeof(IChainSecond).IsAssignableFrom(typeof(ForeignChainReceiver)));
    }

    private static void AssertResolutionLimit(Action action)
    {
        try
        {
            action();
        }
        catch (TypeLoadException exception)
        {
            Assert.True(exception.Message.Contains("Extension interface resolution exceeded", StringComparison.Ordinal));
            return;
        }
        throw new Exception("Expected an incomplete-resolution error, not a cached answer.");
    }

    private sealed class NominalChainFirst : IChainFirst
    {
        public int GetValue() => 83;
    }

    private sealed class DerivedInferenceList : List<int> { }

    private class OpenReferenceReceiver
    {
        public OpenReferenceReceiver() { }
    }

    private sealed class DerivedWithoutDefaultConstructor : OpenReferenceReceiver
    {
        public DerivedWithoutDefaultConstructor(int value) { }
    }

    private class OpenEquatableReceiver : IEquatable<OpenEquatableReceiver>
    {
        public bool Equals(OpenEquatableReceiver? other) => ReferenceEquals(this, other);
    }

    private sealed class SealedEquatableReceiver : IEquatable<SealedEquatableReceiver>
    {
        public bool Equals(SealedEquatableReceiver? other) => ReferenceEquals(this, other);
    }

    private class OpenComparableReceiver : IComparable<OpenComparableReceiver>
    {
        public int CompareTo(OpenComparableReceiver? other) => 0;
    }

    private sealed class DerivedComparableReceiver : OpenComparableReceiver { }

    private sealed class NominalChainSecond : IChainFirst, IChainSecond
    {
        int IChainFirst.GetValue() => 83;
        int IChainSecond.GetValue() => 91;
    }
}
