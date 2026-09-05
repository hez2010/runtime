// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;

public static partial class ExtensionInterfaceTests
{
    private const BindingFlags WitnessMethods = BindingFlags.Public | BindingFlags.NonPublic |
        BindingFlags.Instance | BindingFlags.Static | BindingFlags.DeclaredOnly;

    public static void OpenWitnessDefinitionsAreReused()
    {
        // These declarations are invalid even for the closed pair that happens to
        // match its specialized body. Validation must use the open signatures.
        Assert.Throws<TypeLoadException>(() => typeof(IClosedReceiver).IsAssignableFrom(typeof(OpenReceiver<int>)));
        Assert.Throws<TypeLoadException>(() => typeof(IClosedReceiver).IsAssignableFrom(typeof(OpenReceiver<string>)));
        Assert.Throws<TypeLoadException>(() => typeof(IClosedMember<int>).IsAssignableFrom(typeof(ClosedMemberTarget<int>)));
        Assert.Throws<TypeLoadException>(() => typeof(IClosedMember<string>).IsAssignableFrom(typeof(ClosedMemberTarget<string>)));
        Assert.Throws<TypeLoadException>(() => typeof(IClosedChild<int>).IsAssignableFrom(typeof(ClosedBaseTarget<int>)));
        Assert.Throws<TypeLoadException>(() => typeof(IClosedMember<int>).IsAssignableFrom(typeof(ClosedBaseTarget<int>)));

        Type definition = typeof(IOpenCounter).Assembly.GetType("OpenCounterWitness`1", throwOnError: true)!;
        Assert.True(definition.IsGenericTypeDefinition);
        Assert.Equal(4, definition.GetMethods(WitnessMethods).Length);
        Type receiverParameter = definition.GetGenericArguments()[0];
        Assert.Equal(receiverParameter.MakeByRefType(),
            definition.GetMethod("IncrementBody", WitnessMethods)!.GetParameters()[0].ParameterType);

        VerifyOpenCounter(new SmallCounter { Value = 10 });
        VerifyOpenCounter(new WideCounter { Value = 20, Sentinel = long.MaxValue });
        VerifyOpenCounter(new GenericCounter<string> { Value = 30, Context = "context" });
        VerifyOpenCounter(new GenericCounter<object> { Value = 40, Context = new object() });
        Assert.False(typeof(IOpenCounter).IsAssignableFrom(typeof(int)));
        Assert.False(typeof(IOpenCounter).IsAssignableFrom(typeof(StorageClass)));

        VerifySameWitnessDefinitions(typeof(SmallCounter), typeof(WideCounter), typeof(IOpenCounter), 4);
        VerifySameWitnessDefinitions(typeof(SmallCounter), typeof(GenericCounter<string>), typeof(IOpenCounter), 4);
        VerifySameWitnessDefinitions(typeof(GenericCounter<string>), typeof(GenericCounter<object>), typeof(IOpenCounter), 4);

        // One existing reference-receiver declaration also serves multiple closed types.
        Assert.Equal("interface-owned", ((IInterfaceOwned)(object)"text").GetText());
        Assert.Equal("interface-owned", ((IInterfaceOwned)new object()).GetText());
        VerifySameWitnessDefinitions(typeof(string), typeof(object), typeof(IInterfaceOwned), 4);

        object ints = new List<int> { 1, 2, 3 };
        object strings = new List<string> { "a", "b" };
        object objects = new List<object> { new object() };
        Assert.Equal(3, ((IListCount)ints).Count());
        Assert.Equal(2, ((IListCount)strings).Count());
        Assert.Equal(1, ((IListCount)objects).Count());
        Assert.Same(ints, (IListCount)ints);
        VerifySameWitnessDefinitions(typeof(List<int>), typeof(List<string>), typeof(IListCount), 2);
        VerifySameWitnessDefinitions(typeof(List<string>), typeof(List<object>), typeof(IListCount), 2);

        Type listDefinition = typeof(IListCount).Assembly.GetType("ListCountWitness`1", throwOnError: true)!;
        Assert.Equal(typeof(List<>).MakeGenericType(listDefinition.GetGenericArguments()),
            listDefinition.GetMethod("CountBody", WitnessMethods)!.GetParameters()[0].ParameterType);
    }

    private static void VerifySameWitnessDefinitions(Type firstReceiver, Type secondReceiver, Type contract, int methodCount)
    {
        Type first = firstReceiver.GetInterfaceMap(contract).TargetMethods[0].DeclaringType!;
        Type second = secondReceiver.GetInterfaceMap(contract).TargetMethods[0].DeclaringType!;
        Assert.False(first == second);
        Assert.Equal(first.GetGenericTypeDefinition(), second.GetGenericTypeDefinition());
        Assert.False(first.IsAssignableFrom(firstReceiver));
        Assert.False(second.IsAssignableFrom(secondReceiver));

        MethodInfo[] firstMethods = first.GetMethods(WitnessMethods);
        MethodInfo[] secondMethods = second.GetMethods(WitnessMethods);
        Assert.Equal(methodCount, firstMethods.Length);
        Assert.Equal(methodCount, secondMethods.Length);
        foreach (MethodInfo firstMethod in firstMethods)
        {
            MethodInfo secondMethod = second.GetMethod(firstMethod.Name, WitnessMethods)!;
            VerifySameMethodDefinition(firstMethod, secondMethod);
            if (firstMethod.IsGenericMethodDefinition)
            {
                // Method construction and witness construction must both retain the MethodDef.
                VerifySameMethodDefinition(firstMethod.MakeGenericMethod(typeof(int)), secondMethod.MakeGenericMethod(typeof(string)));
            }
        }
    }

    private static void VerifySameMethodDefinition(MethodInfo first, MethodInfo second)
    {
        Assert.Equal(first.Module, second.Module);
        Assert.Equal(first.MetadataToken, second.MetadataToken);
        byte[] firstIL = first.GetMethodBody()!.GetILAsByteArray()!;
        byte[] secondIL = second.GetMethodBody()!.GetILAsByteArray()!;
        Assert.Equal(firstIL.Length, secondIL.Length);
        for (int i = 0; i < firstIL.Length; i++)
            Assert.Equal(firstIL[i], secondIL[i]);
    }

    private delegate int CounterCall<T>(ref T value) where T : struct;
    private delegate TValue[] CounterEcho<TReceiver, TValue>(ref TReceiver value, TValue[] argument) where TReceiver : struct;

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static int IncrementOpenCounter<T>(ref T value) where T : struct, IOpenCounter => value.Increment();

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static TValue[] EchoOpenCounter<TReceiver, TValue>(ref TReceiver value, TValue[] argument)
        where TReceiver : struct, IOpenCounter => value.Echo(argument);

    private static void VerifyOpenCounter<T>(T original) where T : struct, IOpenStorage
    {
        int initial = original.Read();
        object boxed = original;
        IOpenCounter view = (IOpenCounter)boxed;
        Assert.Same(boxed, view);
        Assert.Equal(typeof(T), view.GetType());
        Assert.Equal(initial + 1, view.Increment());
        Assert.Equal(initial, original.Read());
        int[] ints = { 1, 2 };
        string[] strings = { "one", "two" };
        Assert.Same(ints, view.Echo(ints));
        Assert.Same(strings, view.Echo(strings));
        Assert.Equal(initial + 3, ((T)boxed).Read());
        Assert.DoesNotContain(typeof(IOpenCounter), typeof(T).GetInterfaces());

        var increment = typeof(ExtensionInterfaceTests).GetMethod(nameof(IncrementOpenCounter), BindingFlags.NonPublic | BindingFlags.Static)!
            .MakeGenericMethod(typeof(T)).CreateDelegate<CounterCall<T>>();
        MethodInfo echoDefinition = typeof(ExtensionInterfaceTests).GetMethod(nameof(EchoOpenCounter), BindingFlags.NonPublic | BindingFlags.Static)!;
        var echoInts = echoDefinition.MakeGenericMethod(typeof(T), typeof(int)).CreateDelegate<CounterEcho<T, int>>();
        var echoStrings = echoDefinition.MakeGenericMethod(typeof(T), typeof(string)).CreateDelegate<CounterEcho<T, string>>();
        Assert.Equal(initial + 1, increment(ref original));
        Assert.Same(ints, echoInts(ref original, ints));
        Assert.Same(strings, echoStrings(ref original, strings));
        Assert.Equal(initial + 3, original.Read());

        // Warm up dictionaries and native entry points before checking that ref T
        // reaches the canonical generic body without allocating a box.
        for (int i = 0; i < 100; i++)
            increment(ref original);
        long allocatedBefore = GC.GetAllocatedBytesForCurrentThread();
        for (int i = 0; i < 100; i++)
            increment(ref original);
        long allocatedAfter = GC.GetAllocatedBytesForCurrentThread();
        Assert.Equal(allocatedBefore, allocatedAfter);
        Assert.Equal(initial + 203, original.Read());
        Assert.Equal(initial + 3, ((T)boxed).Read());

        if (original is WideCounter wide)
            Assert.Equal(long.MaxValue, wide.Sentinel);
    }

    private struct SmallCounter : IOpenStorage
    {
        public int Value;
        public int Read() => Value;
        public void Write(int value) => Value = value;
    }

    private struct WideCounter : IOpenStorage
    {
        public long Sentinel;
        public int Value;
        public int Read() => Value;
        public void Write(int value) => Value = value;
    }

    private struct GenericCounter<T> : IOpenStorage
    {
        public T Context;
        public int Value;
        public int Read() => Value;
        public void Write(int value) => Value = value;
    }

    private sealed class StorageClass : IOpenStorage
    {
        public int Read() => 0;
        public void Write(int value) { }
    }
}
