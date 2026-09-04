// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Collections.Generic;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

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
        Console.WriteLine("generic-identity");
        ConstrainedGenericParametersRetainOriginalTypes();
        Console.WriteLine("canonical-calls");
        CanonicalBodiesSupportConstrainedAndStaticCalls();
        Console.WriteLine("coherence");
        CyclesDoNotJustifyThemselvesAndAmbiguityIsStable();
        Console.WriteLine("precedence");
        NominalImplementationsWinAndUnmarkedPairsStayNegative();
        Console.WriteLine("optimized-stress");
        OptimizedAndConcurrentPathsRemainCorrect();
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

    public static void ConstrainedGenericParametersRetainOriginalTypes()
    {
        VerifyReferenceGenericParameterIdentity();
        VerifyIntExtensionImplementation();
        VerifyValueGenericParameterIdentity();
        Assert.Equal(typeof(string), SharedGenericIdentityCalls.RunStringType());
        DeclaredInterfacesOnForeignTypesRetainGenericIdentity();
        ForeignInterfacesOnDeclaredTypesRetainGenericIdentity();
        GenericVirtualMethodsRetainGenericIdentity();
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static void VerifyReferenceGenericParameterIdentity() =>
        Assert.Equal(typeof(TypeOwnedTarget), GenericIdentityCalls.RunReferenceType());

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static void VerifyIntExtensionImplementation()
    {
        object value = 42;
        Assert.True(value is IFoo);
        Assert.Equal(42, ((IFoo)value).GetValue());
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static void VerifyValueGenericParameterIdentity() =>
        Assert.Equal(typeof(int), GenericIdentityCalls.RunValueType());

    private static void DeclaredInterfacesOnForeignTypesRetainGenericIdentity()
    {
        Assert.Equal(typeof(ForeignOrdinaryClass), IdentityMatrixCalls.RunDeclaredInterfaceForeignOrdinaryClass());
        Assert.Equal(typeof(ForeignOrdinaryStruct), IdentityMatrixCalls.RunDeclaredInterfaceForeignOrdinaryStruct());
        Assert.Equal(typeof(ForeignGenericClass<int>), IdentityMatrixCalls.RunDeclaredInterfaceForeignGenericClass());
        Assert.Equal(typeof(ForeignGenericStruct<int>), IdentityMatrixCalls.RunDeclaredInterfaceForeignGenericStruct());
        Assert.Equal(typeof(ForeignConditionalClass<int>), IdentityMatrixCalls.RunDeclaredInterfaceForeignConditionalClass());
        Assert.Equal(typeof(ForeignNestedClass<ForeignGenericStruct<int>>), IdentityMatrixCalls.RunDeclaredInterfaceForeignNested());
        Assert.False(IdentityMatrixCalls.IsDeclaredInterfaceForeignConditionalObjectImplemented());
    }

    private static void ForeignInterfacesOnDeclaredTypesRetainGenericIdentity()
    {
        Assert.Equal(typeof(DeclaredOrdinaryClass), IdentityMatrixCalls.RunForeignInterfaceDeclaredOrdinaryClass());
        Assert.Equal(typeof(DeclaredOrdinaryStruct), IdentityMatrixCalls.RunForeignInterfaceDeclaredOrdinaryStruct());
        Assert.Equal(typeof(DeclaredGenericClass<int>), IdentityMatrixCalls.RunForeignInterfaceDeclaredGenericClass());
        Assert.Equal(typeof(DeclaredGenericStruct<int>), IdentityMatrixCalls.RunForeignInterfaceDeclaredGenericStruct());
        Assert.Equal(typeof(DeclaredConditionalClass<int>), IdentityMatrixCalls.RunForeignInterfaceDeclaredConditionalClass());
        Assert.Equal(typeof(DeclaredNestedClass<ForeignGenericStruct<int>>), IdentityMatrixCalls.RunForeignInterfaceDeclaredNested());
        Assert.False(IdentityMatrixCalls.IsForeignInterfaceDeclaredConditionalObjectImplemented());
    }

    private static void GenericVirtualMethodsRetainGenericIdentity()
    {
        Assert.Equal(typeof(ForeignGenericMethodClass), GenericVirtualMethodCalls.RunDeclaredInterfaceForeignClass());
        Assert.Equal(typeof(ForeignGenericMethodStruct), GenericVirtualMethodCalls.RunDeclaredInterfaceForeignStruct());
        Assert.Equal(typeof(DeclaredGenericMethodClass), GenericVirtualMethodCalls.RunForeignInterfaceDeclaredClass());
        Assert.Equal(typeof(DeclaredGenericMethodStruct), GenericVirtualMethodCalls.RunForeignInterfaceDeclaredStruct());
        Assert.Equal(typeof(ForeignGenericTypeMethodClass<int>), GenericTypeVirtualMethodCalls.RunDeclaredInterfaceForeignType());
        Assert.Equal(typeof(DeclaredGenericTypeMethodClass<int>), GenericTypeVirtualMethodCalls.RunForeignInterfaceDeclaredType());
        Assert.Equal(typeof(ForeignGenericTypeMethodClass<string>), SharedGenericTypeVirtualMethodCalls.RunDeclaredInterfaceForeignType());
        Assert.Equal(typeof(DeclaredGenericTypeMethodClass<string>), SharedGenericTypeVirtualMethodCalls.RunForeignInterfaceDeclaredType());
    }

    public static void CanonicalBodiesSupportConstrainedAndStaticCalls()
    {
        Assert.Equal(55, CanonicalCalls.DirectReferenceCall(new DevirtualizationTarget(55)));
        Assert.Throws<NullReferenceException>(() => CanonicalCalls.DirectReferenceCall(null!));

        Assert.Equal(11, CanonicalCalls.RunValueConstraint());
        Assert.True(typeof(IValueOwned).IsAssignableFrom(typeof(ValueTarget)));
        Assert.Equal(typeof(ValueTarget),
            typeof(ValueConstraintHolder<>).MakeGenericType(typeof(ValueTarget)).GetGenericArguments()[0]);

        Assert.Equal(21, GenericValueCalls.Run());
        Type applicableGenericValue = typeof(GenericValueTarget<TypeOwnedTarget>);
        Assert.True(typeof(IValueOwned).IsAssignableFrom(applicableGenericValue));
        Assert.Equal(applicableGenericValue,
            typeof(ValueConstraintHolder<>).MakeGenericType(applicableGenericValue).GetGenericArguments()[0]);
        Assert.False(typeof(IValueOwned).IsAssignableFrom(typeof(GenericValueTarget<string>)));
        Assert.Throws<ArgumentException>(() =>
            typeof(ValueConstraintHolder<>).MakeGenericType(typeof(GenericValueTarget<string>)));

        Assert.Equal(42, CanonicalCalls.RunStaticConstraint());
        Assert.True(typeof(IStaticOwned).IsAssignableFrom(typeof(StaticTarget)));
        Assert.Equal(typeof(StaticTarget),
            typeof(StaticConstraintHolder<>).MakeGenericType(typeof(StaticTarget)).GetGenericArguments()[0]);

        Assert.Equal(43, ReferenceCalls.RunStaticConstraint());
        Assert.True(typeof(IStaticOwned).IsAssignableFrom(typeof(StaticReferenceTarget)));
        Assert.Equal(typeof(StaticReferenceTarget),
            typeof(StaticConstraintHolder<>).MakeGenericType(typeof(StaticReferenceTarget)).GetGenericArguments()[0]);
    }

    private sealed class ValueConstraintHolder<T> where T : IValueOwned
    {
    }

    private sealed class StaticConstraintHolder<T> where T : IStaticOwned
    {
    }

    public static void OptimizedAndConcurrentPathsRemainCorrect()
    {
        const int Iterations = 1_000_000;

        var devirtualized = new DevirtualizationTarget(7);
        object boxedValue = new ValueTarget { Value = 0 };
        IValueOwned boxedView = (IValueOwned)boxedValue;
        int checksum = 0;

        // This loop is intentionally large enough to exercise optimized Tier 1
        // code when the test is run with tiering and dynamic PGO enabled.
        for (int i = 0; i < Iterations; i++)
        {
            checksum += CanonicalCalls.DirectReferenceCall(devirtualized);
            checksum += CanonicalCalls.RunValueConstraint();
            checksum += GenericValueCalls.Run();
            checksum += CanonicalCalls.RunStaticConstraint();
            checksum += ReferenceCalls.RunStaticConstraint();
            boxedView.Increment();
        }

        Assert.Equal(124_000_000, checksum);
        Assert.Equal(Iterations, boxedView.GetValue());

        // Warm the exact constrained entries, then prove that the value-type
        // receiver paths do not allocate a box in steady state.
        for (int i = 0; i < 100; i++)
        {
            GC.KeepAlive(CanonicalCalls.RunValueConstraint());
            GC.KeepAlive(GenericValueCalls.Run());
        }

        long allocatedBefore = GC.GetAllocatedBytesForCurrentThread();
        for (int i = 0; i < 100_000; i++)
        {
            checksum += CanonicalCalls.RunValueConstraint();
            checksum += GenericValueCalls.Run();
        }
        long allocatedAfter = GC.GetAllocatedBytesForCurrentThread();
        Assert.Equal(0L, allocatedAfter - allocatedBefore);

        // Use pairs not touched by the basic tests so several threads race the
        // first positive, negative, recursive, and generic-value resolutions.
        object derived = new DerivedTypeOwnedTarget(29);
        object conditional = new ConditionalTarget<DerivedTypeOwnedTarget>();
        object rejectedConditional = new ConditionalTarget<object>();
        object genericValue = new GenericValueTarget<DerivedTypeOwnedTarget> { Value = 37 };
        int workerCount = Math.Min(Environment.ProcessorCount, 16);
        using var start = new Barrier(workerCount);
        var workers = new Task[workerCount];

        for (int worker = 0; worker < workers.Length; worker++)
        {
            workers[worker] = Task.Run(() =>
            {
                start.SignalAndWait();
                for (int iteration = 0; iteration < 10_000; iteration++)
                {
                    Assert.True(derived is ITypeOwned);
                    Assert.Equal(29, ((ITypeOwned)derived).GetValue());
                    Assert.True(conditional is IConditional);
                    Assert.Equal(123, ((IConditional)conditional).GetValue());
                    Assert.False(rejectedConditional is IConditional);
                    Assert.True(genericValue is IValueOwned);
                    Assert.Equal(37, ((IValueOwned)genericValue).GetValue());
                }
            });
        }

        Task.WaitAll(workers);

        // Exercise multiple exact instantiations of the shared generic
        // constrained path. Closing the methods itself validates the extension
        // interface constraints.
        VerifyConstrainedValueInstantiation(new ValueTarget { Value = 41 }, 42);
        VerifyConstrainedValueInstantiation(new GenericValueTarget<TypeOwnedTarget> { Value = 42 }, 43);
        VerifyConstrainedValueInstantiation(new GenericValueTarget<DerivedTypeOwnedTarget> { Value = 43 }, 44);
    }

    private delegate void RefAction<T>(ref T value);

    private static void VerifyConstrainedValueInstantiation<T>(T value, int expected)
    {
        MethodInfo method = typeof(ExtensionInterfaceTests)
            .GetMethod(nameof(IncrementThroughConstraint), BindingFlags.NonPublic | BindingFlags.Static)!
            .MakeGenericMethod(typeof(T));
        var increment = (RefAction<T>)method.CreateDelegate(typeof(RefAction<T>));
        increment(ref value);

        object boxed = value!;
        Assert.Equal(expected, ((IValueOwned)boxed).GetValue());
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    private static void IncrementThroughConstraint<T>(ref T value) where T : IValueOwned => value.Increment();

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
