// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.InteropServices;

public static class ExtensionInterfaceTests
{
    public static int Main()
    {
        Console.WriteLine("type-owned");
        CastDispatchAndReflectionUseTheSameWitness();
        Console.WriteLine("interface-owned");
        InterfaceOwnedGenericWitnessSupportsBaseInterfaces();
        Console.WriteLine("value-type");
        BoxedValueTypeUsesTheOriginalBox();
        Console.WriteLine("constraints");
        ConditionalGenericsUseExtensionAwareConstraints();
        Console.WriteLine("coherence");
        CyclesDoNotJustifyThemselvesAndAmbiguityIsStable();
        Console.WriteLine("precedence");
        NominalImplementationsWinAndUnmarkedPairsStayNegative();
        Console.WriteLine("passed");
        return 100;
    }

    public static void CastDispatchAndReflectionUseTheSameWitness()
    {
        object value = new TypeOwnedTarget(42);

        Assert.True(value is ITypeOwned);
        ITypeOwned view = (ITypeOwned)value;
        Assert.Same(value, view);
        Assert.Equal(typeof(TypeOwnedTarget), view.GetType());
        Assert.Equal(42, view.GetValue());
        Assert.Equal(42, view.GetValue());

        Func<int> getValue = view.GetValue;
        Assert.Equal(42, getValue());

        ITypeOwned[] values = new ITypeOwned[1];
        values[0] = (ITypeOwned)value;
        Assert.Same(value, values[0]);

        object[] covariantValues = new ITypeOwned[1];
        covariantValues[0] = value;
        Assert.Same(value, covariantValues[0]);

        Assert.True(typeof(ITypeOwned).IsAssignableFrom(typeof(TypeOwnedTarget)));
        Assert.True(typeof(ITypeOwned).IsAssignableFrom(typeof(DerivedTypeOwnedTarget)));
        Assert.DoesNotContain(typeof(ITypeOwned), typeof(TypeOwnedTarget).GetInterfaces());

        InterfaceMapping map = typeof(TypeOwnedTarget).GetInterfaceMap(typeof(ITypeOwned));
        Assert.Single(map.InterfaceMethods);
        Assert.Equal("TypeOwnedWitness", map.TargetMethods[0].DeclaringType!.Name);
        Assert.False(map.TargetMethods[0].DeclaringType.IsAssignableFrom(typeof(TypeOwnedTarget)));
        Assert.False(map.TargetMethods[0].DeclaringType.IsInstanceOfType(value));

        object derived = new DerivedTypeOwnedTarget(84);
        Assert.Equal(84, ((ITypeOwned)derived).GetValue());
    }

    public static void InterfaceOwnedGenericWitnessSupportsBaseInterfaces()
    {
        object value = "receiver";

        Assert.True(value is IInterfaceOwned);
        Assert.True(value is IBaseExtensionInterface);
        Assert.Equal("interface-owned", ((IInterfaceOwned)value).GetText());
        Assert.Equal(31, ((IBaseExtensionInterface)value).GetBaseValue());

        object[] covariantValues = new IInterfaceOwned[1];
        covariantValues[0] = value;
        Assert.Same(value, covariantValues[0]);

        Assert.True(typeof(IInterfaceOwned).IsAssignableFrom(typeof(string)));
        Assert.True(typeof(IBaseExtensionInterface).IsAssignableFrom(typeof(string)));
        Assert.DoesNotContain(typeof(IInterfaceOwned), typeof(string).GetInterfaces());
        Assert.DoesNotContain(typeof(IBaseExtensionInterface), typeof(string).GetInterfaces());

        InterfaceMapping map = typeof(string).GetInterfaceMap(typeof(IInterfaceOwned));
        Assert.Single(map.InterfaceMethods);
        Assert.StartsWith("InterfaceOwnedWitness`1", map.TargetMethods[0].DeclaringType!.Name);

        InterfaceMapping baseMap = typeof(string).GetInterfaceMap(typeof(IBaseExtensionInterface));
        Assert.Single(baseMap.InterfaceMethods);
        Assert.StartsWith("InterfaceOwnedWitness`1", baseMap.TargetMethods[0].DeclaringType!.Name);
    }

    public static void NominalImplementationsWinAndUnmarkedPairsStayNegative()
    {
        object nominal = new NominalTarget();
        Assert.Equal("nominal", ((IInterfaceOwned)nominal).GetText());
        Assert.Equal(77, ((IBaseExtensionInterface)nominal).GetBaseValue());

        Assert.False(new TypeOwnedTarget(1) is INonParticipating);
        Assert.False((object)123 is IInterfaceOwned);

        var dynamicTarget = new RejectingDynamicTarget();
        Assert.Equal("interface-owned", ((IInterfaceOwned)(object)dynamicTarget).GetText());
        Assert.Equal(0, dynamicTarget.RequestCount);
        Assert.False((object)dynamicTarget is INonParticipating);
        Assert.Equal(1, dynamicTarget.RequestCount);
    }

    public static void BoxedValueTypeUsesTheOriginalBox()
    {
        ValueTarget unboxed = new ValueTarget { Value = 10 };
        object boxed = unboxed;

        Assert.True(boxed is IValueOwned);
        IValueOwned view = (IValueOwned)boxed;
        Assert.Same(boxed, view);
        Assert.Equal(10, view.GetValue());
        view.Increment();
        Assert.Equal(11, view.GetValue());
        Assert.Equal(10, unboxed.Value);

        Assert.True(typeof(IValueOwned).IsAssignableFrom(typeof(ValueTarget)));
        Assert.DoesNotContain(typeof(IValueOwned), typeof(ValueTarget).GetInterfaces());

        InterfaceMapping map = typeof(ValueTarget).GetInterfaceMap(typeof(IValueOwned));
        Assert.Equal(2, map.InterfaceMethods.Length);
        Assert.Equal("ValueWitness", map.TargetMethods[0].DeclaringType!.Name);
        Assert.Equal("ValueWitness", map.TargetMethods[1].DeclaringType!.Name);
    }

    public static void ConditionalGenericsUseExtensionAwareConstraints()
    {
        object applicable = new ConditionalTarget<TypeOwnedTarget>();
        object notApplicable = new ConditionalTarget<string>();

        Assert.True(applicable is IConditional);
        Assert.Equal(123, ((IConditional)applicable).GetValue());
        Assert.False(notApplicable is IConditional);

        Type closedHolder = typeof(ConstraintHolder<>).MakeGenericType(typeof(TypeOwnedTarget));
        Assert.Equal(typeof(TypeOwnedTarget), closedHolder.GetGenericArguments()[0]);

        MethodInfo constrainedCall = typeof(ExtensionInterfaceTests)
            .GetMethod(nameof(ReadThroughConstraint), BindingFlags.NonPublic | BindingFlags.Static)!
            .MakeGenericMethod(typeof(TypeOwnedTarget));
        Assert.Equal(19, (int)constrainedCall.Invoke(null, new object[] { new TypeOwnedTarget(19) })!);
    }

    private static int ReadThroughConstraint<T>(T value) where T : ITypeOwned => value.GetValue();

    private sealed class ConstraintHolder<T> where T : ITypeOwned
    {
    }

    public static void CyclesDoNotJustifyThemselvesAndAmbiguityIsStable()
    {
        Assert.False((object)new SelfTarget() is ISelfJustifying);

        object ambiguous = new AmbiguousTarget();
        Assert.Throws<TypeLoadException>(() => GC.KeepAlive((IAmbiguous)ambiguous));
        Assert.Throws<TypeLoadException>(() => GC.KeepAlive((IAmbiguous)ambiguous));
    }

    private sealed class SelfTarget
    {
    }

    private sealed class RejectingDynamicTarget : IDynamicInterfaceCastable
    {
        public int RequestCount { get; private set; }

        public bool IsInterfaceImplemented(RuntimeTypeHandle interfaceType, bool throwIfNotImplemented)
        {
            RequestCount++;
            if (throwIfNotImplemented)
                throw new InvalidCastException();

            return false;
        }

        public RuntimeTypeHandle GetInterfaceImplementation(RuntimeTypeHandle interfaceType) => throw new InvalidOperationException();
    }

    private static class Assert
    {
        public static void True(bool condition)
        {
            if (!condition)
                throw new Exception("Expected true.");
        }

        public static void False(bool condition)
        {
            if (condition)
                throw new Exception("Expected false.");
        }

        public static void Equal<T>(T expected, T actual)
        {
            if (!EqualityComparer<T>.Default.Equals(expected, actual))
                throw new Exception($"Expected '{expected}', got '{actual}'.");
        }

        public static void Same(object expected, object actual)
        {
            if (!ReferenceEquals(expected, actual))
                throw new Exception("Expected identical object references.");
        }

        public static void DoesNotContain<T>(T expected, IEnumerable<T> values)
        {
            foreach (T value in values)
            {
                if (EqualityComparer<T>.Default.Equals(expected, value))
                    throw new Exception($"Did not expect '{expected}'.");
            }
        }

        public static void Single<T>(IReadOnlyCollection<T> values)
        {
            if (values.Count != 1)
                throw new Exception($"Expected one value, got {values.Count}.");
        }

        public static void StartsWith(string expectedStart, string actual)
        {
            if (!actual.StartsWith(expectedStart, StringComparison.Ordinal))
                throw new Exception($"Expected '{actual}' to start with '{expectedStart}'.");
        }

        public static void Throws<T>(Action action) where T : Exception
        {
            try
            {
                action();
            }
            catch (T)
            {
                return;
            }

            throw new Exception($"Expected {typeof(T)}.");
        }
    }
}
