// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Threading.Tasks;

public static partial class ExtensionInterfaceTests
{
    public static void WitnessArgumentsAreInferred()
    {
        ContractArgumentsSupplyWitnessArguments();
        NominalConstraintsSupplyWitnessArguments();
        InferencePreservesInterfaceConversions();
        InferenceSupportsSharedValueCalls();
        CovariantCanonicalBodiesUseTheirDeclaredSignatures();
        RecursiveInferenceDoesNotCacheAProvisionalWinner();
        ConcurrentInferencePreservesBindings();
    }

    private static Type InferredWitness(Type receiver, Type contract) =>
        receiver.GetInterfaceMap(contract).TargetMethods[0].DeclaringType!;

    private static void AssertWitnessArguments(Type witness, params Type[] expected)
    {
        Type[] actual = witness.GetGenericArguments();
        Assert.Equal(expected.Length, actual.Length);
        for (int i = 0; i < expected.Length; i++)
            Assert.Equal(expected[i], actual[i]);
    }

    private static void ContractArgumentsSupplyWitnessArguments()
    {
        object receiver = new InferenceReceiver();
        var ints = (IInferred<int>)receiver;
        var strings = (IInferred<string>)receiver;
        Assert.Same(receiver, ints);
        Assert.Same(receiver, strings);
        Assert.Equal(typeof(InferenceReceiver), ints.GetType());
        Assert.Equal(42, ints.Echo(42));
        Assert.Equal("value", strings.Echo("value"));
        string[] stringValues = { "method" };
        int[] intValues = { 17 };
        Assert.Same(stringValues, ints.EchoMethod(1, stringValues));
        Assert.Same(intValues, strings.EchoMethod("context", intValues));
        Assert.Same(stringValues, strings.EchoMethod("context", stringValues));
        var methodArgument = new InferredMethodArgument();
        Assert.Same(methodArgument, InferenceCalls.ContractConstrained<int>(receiver, methodArgument));
        Assert.Same(methodArgument, InferenceCalls.ContractConstrained<string>(receiver, methodArgument));
        Func<int, int> echo = ints.Echo;
        Assert.Equal(19, echo(19));

        Type first = InferredWitness(typeof(InferenceReceiver), typeof(IInferred<int>));
        Type second = InferredWitness(typeof(InferenceReceiver), typeof(IInferred<string>));
        AssertWitnessArguments(first, typeof(InferenceReceiver), typeof(int));
        AssertWitnessArguments(second, typeof(InferenceReceiver), typeof(string));
        Assert.Equal(first.GetGenericTypeDefinition(), second.GetGenericTypeDefinition());
        Assert.Equal(6, first.GetMethods(WitnessMethods).Length);
        foreach (MethodInfo method in first.GetMethods(WitnessMethods))
            VerifySameMethodDefinition(method, second.GetMethod(method.Name, WitnessMethods)!);

        Assert.False(typeof(IInferred<int>).IsAssignableFrom(typeof(object)));
        Assert.False(typeof(IInferred<int>).IsAssignableFrom(typeof(InferenceStruct)));
        Assert.False(typeof(IInferred<>).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.DoesNotContain(typeof(IInferred<int>), typeof(InferenceReceiver).GetInterfaces());

        // A known contract argument may make an extension-satisfied constraint usable.
        Assert.True(typeof(IInferenceElement<int>).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.Equal(typeof(int), ((IExtensionConstraintInference<int>)receiver).GetElementType());
        Assert.False(typeof(IExtensionConstraintInference<string>).IsAssignableFrom(typeof(InferenceReceiver)));
        // Extension satisfaction does not manufacture nominal projections for inference.
        Assert.False(typeof(IElementInference).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.Equal(typeof(int), InferenceCalls.StaticElement<InferenceReceiver, int>());
        Assert.Equal(typeof(string), InferenceCalls.StaticElement<InferenceReceiver, string>());
        Assert.Equal(typeof(object), InferenceCalls.StaticElement<InferenceReceiver, object>());
    }

    private static void NominalConstraintsSupplyWitnessArguments()
    {
        object ints = new List<int>();
        object strings = new List<string>();
        Assert.Equal(typeof(int), ((IListInference)ints).GetElementType());
        Assert.Equal(typeof(string), ((IListInference)strings).GetElementType());
        AssertWitnessArguments(InferredWitness(typeof(List<int>), typeof(IListInference)), typeof(int), typeof(List<int>));
        AssertWitnessArguments(InferredWitness(typeof(List<string>), typeof(IListInference)), typeof(string), typeof(List<string>));
        Assert.False(typeof(IListInference).IsAssignableFrom(typeof(object)));
        VerifySameWitnessDefinitions(typeof(List<int>), typeof(List<string>), typeof(IListInference), 2);

        Assert.Equal(typeof(string), ((IChainedInference)(object)new InferenceChain()).GetElementType());
        AssertWitnessArguments(InferredWitness(typeof(InferenceChain), typeof(IChainedInference)),
            typeof(InferenceMiddle), typeof(string), typeof(InferenceChain));
        Assert.Equal(typeof(string), ((IContractChainInference<InferenceMiddle>)(object)new InferenceReceiver()).GetElementType());
        Assert.False(typeof(IContractChainInference<string>).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.False(typeof(IUnseededInference).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.Equal(typeof(InferenceCycleSecond), ((ISeededInference<InferenceCycleFirst>)(object)new InferenceReceiver()).GetElementType());

        // Both element projections match initially; the additional constraint selects string.
        Assert.Equal(typeof(string), ((ISelectedInference)(object)new SelectedInferenceReceiver()).GetElementType());
        // The int/string projection fails after binding its first argument. Its binding
        // must not leak into the subsequent string/string candidate.
        Assert.Equal(typeof(string), ((IRepeatedInference)(object)new RepeatedInferenceReceiver()).GetElementType());

        for (int i = 0; i < 2; i++)
            Assert.Throws<TypeLoadException>(() => typeof(IElementInference).IsAssignableFrom(typeof(AmbiguousInferenceReceiver)));
    }

    private static void InferencePreservesInterfaceConversions()
    {
        object receiver = new InferenceReceiver();
        var child = (IInferenceChild<int>)receiver;
        IInferenceBase<List<int>> inherited = child;
        Assert.Same(receiver, inherited);
        Assert.Equal(typeof(int), child.GetChildElementType());
        Assert.Equal(typeof(int), inherited.GetElementType());
        Assert.Equal(InferredWitness(typeof(InferenceReceiver), typeof(IInferenceChild<int>)),
            InferredWitness(typeof(InferenceReceiver), typeof(IInferenceBase<List<int>>)));
        Assert.False(typeof(IInferenceBase<int>).IsAssignableFrom(typeof(InferenceReceiver)));

        Assert.Equal(typeof(string), ((IInferenceLeft<string>)receiver).GetElementType());
        Assert.Equal(typeof(string), ((IInferenceRight<string>)receiver).GetElementType());
        Assert.Equal(InferredWitness(typeof(InferenceReceiver), typeof(IInferenceLeft<string>)),
            InferredWitness(typeof(InferenceReceiver), typeof(IInferenceRight<string>)));

        // Variance checks the already inferred string argument without changing it to object.
        object covariant = new StringInferenceReceiver();
        ICovariantInference<string> exact = (ICovariantInference<string>)covariant;
        ICovariantInference<object> variant = exact;
        Assert.Equal(typeof(string), exact.GetElementType());
        Assert.Equal(typeof(string), variant.GetElementType());
        Assert.Equal(InferredWitness(typeof(StringInferenceReceiver), typeof(ICovariantInference<string>)),
            InferredWitness(typeof(StringInferenceReceiver), typeof(ICovariantInference<object>)));
        Assert.False(typeof(ICovariantInference<int>).IsAssignableFrom(typeof(StringInferenceReceiver)));
        Assert.Equal(typeof(string), ((ICovariantInference<object>)(object)new AmbiguousInferenceReceiver()).GetElementType());
        Assert.Throws<TypeLoadException>(() => typeof(ICovariantInference<string>).IsAssignableFrom(typeof(AmbiguousVariantInferenceReceiver)));
        Assert.Throws<TypeLoadException>(() => typeof(ICovariantInference<object>).IsAssignableFrom(typeof(AmbiguousVariantInferenceReceiver)));

        object mixed = new InferenceContext<object>();
        Assert.Equal(typeof(int), ((IMixedInference<string, int>)mixed).GetElementType());
        AssertWitnessArguments(InferredWitness(typeof(InferenceContext<object>), typeof(IMixedInference<string, int>)),
            typeof(object), typeof(int));
        Assert.False(typeof(IMixedInference<int, string>).IsAssignableFrom(typeof(InferenceContext<object>)));

        // A variant-only occurrence cannot supply an otherwise unknown argument.
        Assert.False(typeof(IVariantOnlyInference<string>).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.False(typeof(IVariantOnlyInference<object>).IsAssignableFrom(typeof(InferenceReceiver)));
        // Nor may a successful child view lose the argument at its implied base interface.
        Assert.Throws<TypeLoadException>(() => typeof(IInferenceTagged<int>).IsAssignableFrom(typeof(InferenceReceiver)));
        Assert.Throws<TypeLoadException>(() => typeof(IInferenceTagged<string>).IsAssignableFrom(typeof(InferenceReceiver)));

        // A nominal base implementation still wins and needs no extension witness.
        object nominal = new NominalInferenceBase();
        Assert.True(nominal is IInferenceTagged<int>);
        Assert.Equal(typeof(decimal), ((IInferenceErased)(IInferenceTagged<int>)nominal).GetElementType());
    }

    private static void InferenceSupportsSharedValueCalls()
    {
        InferredValueTarget value = default;
        Assert.Equal(typeof(int), InferenceCalls.ValueElement<int>(ref value));
        Assert.Equal(typeof(string), InferenceCalls.ValueElement<string>(ref value));
        Assert.Equal(typeof(object), InferenceCalls.ValueElement<object>(ref value));
        Assert.Equal(1, InferenceCalls.ValueIncrement<int>(ref value));
        Assert.Equal(2, InferenceCalls.ValueIncrement<string>(ref value));
        Assert.Equal(3, InferenceCalls.ValueIncrement<object>(ref value));
        Assert.Equal(3, value.Value);
        object boxed = value;
        Assert.Equal(4, ((IValueInference<string>)boxed).Increment());
        Assert.Equal(4, ((InferredValueTarget)boxed).Value);
        Assert.Equal(3, value.Value);

        VerifyInferredBox(new List<int>(), typeof(int));
        VerifyInferredBox(new List<string>(), typeof(string));
        VerifyInferredBox(new List<object>(), typeof(object));
        Assert.False(typeof(IBoxInference).IsAssignableFrom(typeof(InferenceListBox<object>)));
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static void VerifyInferredBox<TList>(TList list, Type element) where TList : class
    {
        var value = new InferenceListBox<TList> { List = list, Version = 1 };
        Assert.Equal(element, InferenceCalls.BoxElement(ref value));
        Assert.Equal(2, InferenceCalls.BoxIncrement(ref value));
        AssertWitnessArguments(InferredWitness(typeof(InferenceListBox<TList>), typeof(IBoxInference)), element, typeof(TList));
        object boxed = value;
        Assert.Equal(element, ((IBoxInference)boxed).GetElementType());
        Assert.Equal(3, ((IBoxInference)boxed).Increment());
        Assert.Equal(2, value.Version);

        for (int i = 0; i < 100; i++)
            InferenceCalls.BoxIncrement(ref value);
        long before = GC.GetAllocatedBytesForCurrentThread();
        for (int i = 0; i < 100; i++)
            InferenceCalls.BoxIncrement(ref value);
        long after = GC.GetAllocatedBytesForCurrentThread();
        Assert.Equal(before, after);
        Assert.Equal(202, value.Version);
        Assert.Same(list, value.List);
    }

    private sealed class InferenceReceiver : IInferenceReceiver { }
    private sealed class ConcurrentInferenceReceiver : IInferenceReceiver { }
    private struct InferenceStruct : IInferenceReceiver { }
    private sealed class StringInferenceReceiver : IInferenceElement<string> { }
    private sealed class AmbiguousInferenceReceiver : IInferenceElement<int>, IInferenceElement<string> { }
    private sealed class AmbiguousVariantInferenceReceiver : IInferenceElement<string>, IInferenceElement<Uri> { }
    private sealed class SelectedInferenceReceiver : IInferenceElement<int>, IInferenceElement<string>, IInferenceSelect<string> { }
    private sealed class RepeatedInferenceReceiver : IInferencePair<int, string>, IInferencePair<string, string> { }
    private sealed class InferenceMiddle : IInferenceElement<string> { }
    private sealed class InferenceChain : IInferenceElement<InferenceMiddle> { }
    private sealed class InferenceCycleFirst : IInferenceElement<InferenceCycleSecond> { }
    private sealed class InferenceCycleSecond : IInferenceElement<InferenceCycleFirst> { }
    private sealed class NominalInferenceProof : IInferenceProof { }
    private sealed class RecursiveInferenceReceiver :
        IInferenceElement<NominalInferenceProof>, IInferenceElement<InferenceProofTarget<RecursiveInferenceReceiver>> { }
    private sealed class NominalInferenceBase : IInferenceReceiver, IInferenceErased
    {
        public Type GetElementType() => typeof(decimal);
    }

    private sealed class InferenceStringValue : IInferenceValue<string>
    {
        public string GetValue() => "covariant";
    }

    private struct InferenceValue<T> : IInferenceValue<T>
    {
        public T Value;
        public T GetValue() => Value;
    }

    private delegate object CovariantCall<T>(ref T value);

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static object ReadCovariantValue<T>(ref T value) where T : ICovariantValueInference<object> => value.GetValue();

    private static void CovariantCanonicalBodiesUseTheirDeclaredSignatures()
    {
        object receiver = new InferenceStringValue();
        Assert.Equal("covariant", (string)((ICovariantValueInference<object>)receiver).GetValue());
        var value = new InferenceValue<string> { Value = "byref" };
        var read = typeof(ExtensionInterfaceTests).GetMethod(nameof(ReadCovariantValue), BindingFlags.NonPublic | BindingFlags.Static)!
            .MakeGenericMethod(typeof(InferenceValue<string>)).CreateDelegate<CovariantCall<InferenceValue<string>>>();
        Assert.Equal("byref", (string)read(ref value));
        for (int i = 0; i < 100; i++)
            read(ref value);
        long before = GC.GetAllocatedBytesForCurrentThread();
        for (int i = 0; i < 100; i++)
            read(ref value);
        Assert.Equal(before, GC.GetAllocatedBytesForCurrentThread());
        Assert.False(typeof(ICovariantValueInference<object>).IsAssignableFrom(typeof(InferenceValue<int>)));
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static object CreateConcurrentReceiver() => new ConcurrentInferenceReceiver();

    private static void ConcurrentInferencePreservesBindings()
    {
        Parallel.For(0, 64, i =>
        {
            object receiver = CreateConcurrentReceiver();
            Assert.Equal(i, ((IInferred<int>)receiver).Echo(i));
            Assert.Equal("concurrent", ((IInferred<string>)receiver).Echo("concurrent"));
            Assert.Equal(typeof(string), ((IInferenceChild<string>)receiver).GetChildElementType());
            Assert.False(typeof(IListInference).IsInstanceOfType(receiver));
        });
    }

    private static void RecursiveInferenceDoesNotCacheAProvisionalWinner()
    {
        // The nominal proof establishes satisfaction. That also enables the
        // recursive proof, so the completed relation has two witnesses.
        for (int i = 0; i < 2; i++)
            Assert.Throws<TypeLoadException>(() => typeof(IRecursiveInference).IsAssignableFrom(typeof(RecursiveInferenceReceiver)));
    }
}
