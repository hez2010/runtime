// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System;
using System.Reflection;
using System.Reflection.Emit;
using System.Runtime.CompilerServices;
using BenchmarkDotNet.Attributes;
using BenchmarkDotNet.Configs;
using BenchmarkDotNet.Running;

namespace ExtensionInterfacePerformance;

public static class Program
{
    public static void Main(string[] args) => BenchmarkSwitcher.FromAssembly(typeof(Program).Assembly).Run(args);
}

public interface INominalReference
{
    int GetValue();
}

public interface INominalBase
{
    int GetBaseValue();
}

public interface INominalInterfaceOwned : INominalBase
{
    string GetText();
}

public interface INominalValue
{
    int GetValue();
    void Increment();
}

public interface INominalStatic
{
    static abstract int Create(int value);
}

public class NominalReferenceTarget : INominalReference
{
    private readonly int _value;

    public NominalReferenceTarget(int value) => _value = value;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public int GetValue() => _value;
}

public sealed class NominalInterfaceOwnedTarget : INominalInterfaceOwned
{
    [MethodImpl(MethodImplOptions.NoInlining)]
    public string GetText() => "nominal";

    [MethodImpl(MethodImplOptions.NoInlining)]
    public int GetBaseValue() => 31;
}

public sealed class NominalDevirtualizationTarget : INominalReference
{
    private readonly int _value;

    public NominalDevirtualizationTarget(int value) => _value = value;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public int GetValue() => _value;
}

public sealed class NominalNegativeTarget
{
}

public struct NominalValueTarget : INominalValue
{
    public int Value;

    public readonly int GetValue() => Value;

    public void Increment() => Value++;
}

public struct NominalGenericValueTarget<T> : INominalValue
{
    public int Value;

    public readonly int GetValue() => Value;

    public void Increment() => Value++;
}

public readonly struct NominalStaticValueTarget : INominalStatic
{
    public static int Create(int value) => value + 2;
}

public sealed class NominalStaticReferenceTarget : INominalStatic
{
    public static int Create(int value) => value + 3;
}

public sealed class NominalConditionalTarget<T> : INominalReference
{
    public int GetValue() => 123;
}

public sealed class NominalRejectedConditionalTarget<T>
{
}

public delegate void RefAction<T>(ref T value);

public static class OrdinaryCallSites
{
    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int DirectReferenceCall(NominalDevirtualizationTarget value) => ((INominalReference)value).GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ReadThroughConstraint<T>(T value) where T : INominalReference => value.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static void IncrementThroughConstraint<T>(ref T value) where T : INominalValue => value.Increment();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int CreateThroughConstraint<T>(int value) where T : INominalStatic => T.Create(value);
}

internal static class OrdinaryOperations
{
    private static object s_referenceObject = new NominalReferenceTarget(42);
    private static INominalReference s_referenceView = (INominalReference)s_referenceObject;
    private static Func<int> s_referenceDelegate = s_referenceView.GetValue;
    private static object s_interfaceOwnedObject = new NominalInterfaceOwnedTarget();
    private static INominalInterfaceOwned s_interfaceOwnedView = (INominalInterfaceOwned)s_interfaceOwnedObject;
    private static INominalBase s_baseView = (INominalBase)s_interfaceOwnedObject;
    private static object s_negativeObject = new NominalNegativeTarget();
    private static INominalReference[] s_referenceArray = new INominalReference[1];
    private static INominalValue s_boxedValue = new NominalValueTarget { Value = 10 };
    private static NominalDevirtualizationTarget s_devirtualizationTarget = new(55);
    private static NominalReferenceTarget s_referenceTarget = new(42);
    private static Func<NominalReferenceTarget, int> s_referenceConstraint = OrdinaryCallSites.ReadThroughConstraint<NominalReferenceTarget>;
    private static NominalValueTarget s_value;
    private static RefAction<NominalValueTarget> s_valueConstraint = OrdinaryCallSites.IncrementThroughConstraint<NominalValueTarget>;
    private static NominalGenericValueTarget<NominalReferenceTarget> s_genericValue;
    private static RefAction<NominalGenericValueTarget<NominalReferenceTarget>> s_genericValueConstraint = OrdinaryCallSites.IncrementThroughConstraint<NominalGenericValueTarget<NominalReferenceTarget>>;
    private static Func<int, int> s_staticValueConstraint = OrdinaryCallSites.CreateThroughConstraint<NominalStaticValueTarget>;
    private static Func<int, int> s_staticReferenceConstraint = OrdinaryCallSites.CreateThroughConstraint<NominalStaticReferenceTarget>;
    private static INominalReference s_conditionalView = new NominalConditionalTarget<NominalReferenceTarget>();
    private static object s_rejectedConditionalObject = new NominalRejectedConditionalTarget<string>();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool PositiveCast() => s_referenceObject is INominalReference;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool InterfaceOwnedPositiveCast() => s_interfaceOwnedObject is INominalInterfaceOwned;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool NegativeCast() => s_negativeObject is INominalReference;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool ExplicitCast() => ReferenceEquals((INominalReference)s_referenceObject, s_referenceObject);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int InterfaceDispatch() => s_referenceView.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int InterfaceOwnedDispatch() => s_interfaceOwnedView.GetText().Length;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int BaseInterfaceDispatch() => s_baseView.GetBaseValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int DelegateDispatch() => s_referenceDelegate();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ArrayStore()
    {
        s_referenceArray[0] = (INominalReference)s_referenceObject;
        return s_referenceArray[0].GetValue();
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int BoxedValueGet() => s_boxedValue.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int BoxedValueIncrement()
    {
        s_boxedValue.Increment();
        return s_boxedValue.GetValue();
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ExactDevirtualization() => OrdinaryCallSites.DirectReferenceCall(s_devirtualizationTarget);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ReferenceConstraint() => s_referenceConstraint(s_referenceTarget);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ValueConstraint()
    {
        s_valueConstraint(ref s_value);
        return s_value.Value;
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int GenericValueConstraint()
    {
        s_genericValueConstraint(ref s_genericValue);
        return s_genericValue.Value;
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int StaticValueConstraint() => s_staticValueConstraint(40);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int StaticReferenceConstraint() => s_staticReferenceConstraint(40);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ConditionalPositiveDispatch() => s_conditionalView.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool ConditionalNegativeCast() => s_rejectedConditionalObject is INominalReference;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool ReflectionIsAssignable() => typeof(INominalReference).IsAssignableFrom(typeof(NominalReferenceTarget));

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ReflectionInterfaceMap() => typeof(NominalReferenceTarget).GetInterfaceMap(typeof(INominalReference)).TargetMethods.Length;
}

[MemoryDiagnoser]
public class OrdinaryHotBenchmarks
{
    [Benchmark] public bool PositiveCast() => OrdinaryOperations.PositiveCast();
    [Benchmark] public bool InterfaceOwnedPositiveCast() => OrdinaryOperations.InterfaceOwnedPositiveCast();
    [Benchmark] public bool NegativeCast() => OrdinaryOperations.NegativeCast();
    [Benchmark] public bool ExplicitCast() => OrdinaryOperations.ExplicitCast();
    [Benchmark] public int InterfaceDispatch() => OrdinaryOperations.InterfaceDispatch();
    [Benchmark] public int InterfaceOwnedDispatch() => OrdinaryOperations.InterfaceOwnedDispatch();
    [Benchmark] public int BaseInterfaceDispatch() => OrdinaryOperations.BaseInterfaceDispatch();
    [Benchmark] public int DelegateDispatch() => OrdinaryOperations.DelegateDispatch();
    [Benchmark] public int ArrayStore() => OrdinaryOperations.ArrayStore();
    [Benchmark] public int BoxedValueGet() => OrdinaryOperations.BoxedValueGet();
    [Benchmark] public int BoxedValueIncrement() => OrdinaryOperations.BoxedValueIncrement();
    [Benchmark] public int ExactDevirtualization() => OrdinaryOperations.ExactDevirtualization();
    [Benchmark] public int ReferenceConstraint() => OrdinaryOperations.ReferenceConstraint();
    [Benchmark] public int ValueConstraint() => OrdinaryOperations.ValueConstraint();
    [Benchmark] public int GenericValueConstraint() => OrdinaryOperations.GenericValueConstraint();
    [Benchmark] public int StaticValueConstraint() => OrdinaryOperations.StaticValueConstraint();
    [Benchmark] public int StaticReferenceConstraint() => OrdinaryOperations.StaticReferenceConstraint();
    [Benchmark] public int ConditionalPositiveDispatch() => OrdinaryOperations.ConditionalPositiveDispatch();
    [Benchmark] public bool ConditionalNegativeCast() => OrdinaryOperations.ConditionalNegativeCast();
    [Benchmark] public bool ReflectionIsAssignable() => OrdinaryOperations.ReflectionIsAssignable();
    [Benchmark] public int ReflectionInterfaceMap() => OrdinaryOperations.ReflectionInterfaceMap();
}

#if EXTENSION_INTERFACE
public static class ExtensionCallSites
{
    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ReadThroughConstraint<T>(T value) where T : ITypeOwned => value.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static void IncrementThroughConstraint<T>(ref T value) where T : IValueOwned => value.Increment();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int CreateThroughConstraint<T>(int value) where T : IStaticOwned => T.Create(value);
}

internal static class ExtensionOperations
{
    private static object s_typeOwnedObject = new TypeOwnedTarget(42);
    private static ITypeOwned s_typeOwnedView = (ITypeOwned)s_typeOwnedObject;
    private static Func<int> s_typeOwnedDelegate = s_typeOwnedView.GetValue;
    private static object s_interfaceOwnedObject = "receiver";
    private static IInterfaceOwned s_interfaceOwnedView = (IInterfaceOwned)s_interfaceOwnedObject;
    private static IBaseExtensionInterface s_baseView = (IBaseExtensionInterface)s_interfaceOwnedObject;
    private static object s_unmarkedObject = new TypeOwnedTarget(1);
    private static ITypeOwned[] s_typeOwnedArray = new ITypeOwned[1];
    private static IValueOwned s_boxedValue = (IValueOwned)(object)new ValueTarget { Value = 10 };
    private static DevirtualizationTarget s_devirtualizationTarget = new(55);
    private static TypeOwnedTarget s_referenceTarget = new(42);
    private static Func<TypeOwnedTarget, int> s_referenceConstraint = CreateDelegate<Func<TypeOwnedTarget, int>>(
        nameof(ExtensionCallSites.ReadThroughConstraint), typeof(TypeOwnedTarget));
    private static ValueTarget s_value;
    private static RefAction<ValueTarget> s_valueConstraint = CreateDelegate<RefAction<ValueTarget>>(
        nameof(ExtensionCallSites.IncrementThroughConstraint), typeof(ValueTarget));
    private static GenericValueTarget<TypeOwnedTarget> s_genericValue;
    private static RefAction<GenericValueTarget<TypeOwnedTarget>> s_genericValueConstraint = CreateDelegate<RefAction<GenericValueTarget<TypeOwnedTarget>>>(
        nameof(ExtensionCallSites.IncrementThroughConstraint), typeof(GenericValueTarget<TypeOwnedTarget>));
    private static Func<int, int> s_staticValueConstraint = CreateDelegate<Func<int, int>>(
        nameof(ExtensionCallSites.CreateThroughConstraint), typeof(StaticTarget));
    private static Func<int, int> s_staticReferenceConstraint = CreateDelegate<Func<int, int>>(
        nameof(ExtensionCallSites.CreateThroughConstraint), typeof(StaticReferenceTarget));
    private static IConditional s_conditionalView = (IConditional)(object)new ConditionalTarget<TypeOwnedTarget>();
    private static object s_rejectedConditionalObject = new ConditionalTarget<string>();

    private static TDelegate CreateDelegate<TDelegate>(string methodName, Type typeArgument) where TDelegate : Delegate
    {
        MethodInfo definition = typeof(ExtensionCallSites).GetMethod(methodName, BindingFlags.Public | BindingFlags.Static)!;
        return definition.MakeGenericMethod(typeArgument).CreateDelegate<TDelegate>();
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool TypeOwnedPositiveCast() => s_typeOwnedObject is ITypeOwned;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool InterfaceOwnedPositiveCast() => s_interfaceOwnedObject is IInterfaceOwned;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool UnrelatedNegativeCast() => s_unmarkedObject is INonParticipating;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool ExplicitCast() => ReferenceEquals((ITypeOwned)s_typeOwnedObject, s_typeOwnedObject);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int TypeOwnedDispatch() => s_typeOwnedView.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int InterfaceOwnedDispatch() => s_interfaceOwnedView.GetText().Length;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int BaseInterfaceDispatch() => s_baseView.GetBaseValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int DelegateDispatch() => s_typeOwnedDelegate();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ArrayStore()
    {
        s_typeOwnedArray[0] = (ITypeOwned)s_typeOwnedObject;
        return s_typeOwnedArray[0].GetValue();
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int BoxedValueGet() => s_boxedValue.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int BoxedValueIncrement()
    {
        s_boxedValue.Increment();
        return s_boxedValue.GetValue();
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ExactDevirtualization() => Stage2Calls.DirectReferenceCall(s_devirtualizationTarget);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ReferenceConstraint() => s_referenceConstraint(s_referenceTarget);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ValueConstraint()
    {
        s_valueConstraint(ref s_value);
        return s_value.Value;
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int GenericValueConstraint()
    {
        s_genericValueConstraint(ref s_genericValue);
        return s_genericValue.Value;
    }

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int StaticValueConstraint() => s_staticValueConstraint(40);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int StaticReferenceConstraint() => s_staticReferenceConstraint(40);

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ConditionalPositiveDispatch() => s_conditionalView.GetValue();

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool ConditionalNegativeCast() => s_rejectedConditionalObject is IConditional;

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static bool ReflectionIsAssignable() => typeof(ITypeOwned).IsAssignableFrom(typeof(TypeOwnedTarget));

    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int ReflectionInterfaceMap() => typeof(TypeOwnedTarget).GetInterfaceMap(typeof(ITypeOwned)).TargetMethods.Length;
}

[MemoryDiagnoser]
[CategoriesColumn]
[GroupBenchmarksBy(BenchmarkLogicalGroupRule.ByCategory)]
public class ExtensionHotBenchmarks
{
    [Benchmark(Baseline = true), BenchmarkCategory("cast-positive-type-owned")]
    public bool NominalTypeOwnedPositiveCast() => OrdinaryOperations.PositiveCast();

    [Benchmark, BenchmarkCategory("cast-positive-type-owned")]
    public bool ExtensionTypeOwnedPositiveCast() => ExtensionOperations.TypeOwnedPositiveCast();

    [Benchmark(Baseline = true), BenchmarkCategory("cast-positive-interface-owned")]
    public bool NominalInterfaceOwnedPositiveCast() => OrdinaryOperations.InterfaceOwnedPositiveCast();

    [Benchmark, BenchmarkCategory("cast-positive-interface-owned")]
    public bool ExtensionInterfaceOwnedPositiveCast() => ExtensionOperations.InterfaceOwnedPositiveCast();

    [Benchmark(Baseline = true), BenchmarkCategory("cast-unrelated-negative")]
    public bool NominalUnrelatedNegativeCast() => OrdinaryOperations.NegativeCast();

    [Benchmark, BenchmarkCategory("cast-unrelated-negative")]
    public bool ExtensionUnrelatedNegativeCast() => ExtensionOperations.UnrelatedNegativeCast();

    [Benchmark(Baseline = true), BenchmarkCategory("cast-explicit")]
    public bool NominalExplicitCast() => OrdinaryOperations.ExplicitCast();

    [Benchmark, BenchmarkCategory("cast-explicit")]
    public bool ExtensionExplicitCast() => ExtensionOperations.ExplicitCast();

    [Benchmark(Baseline = true), BenchmarkCategory("dispatch-type-owned")]
    public int NominalTypeOwnedDispatch() => OrdinaryOperations.InterfaceDispatch();

    [Benchmark, BenchmarkCategory("dispatch-type-owned")]
    public int ExtensionTypeOwnedDispatch() => ExtensionOperations.TypeOwnedDispatch();

    [Benchmark(Baseline = true), BenchmarkCategory("dispatch-interface-owned")]
    public int NominalInterfaceOwnedDispatch() => OrdinaryOperations.InterfaceOwnedDispatch();

    [Benchmark, BenchmarkCategory("dispatch-interface-owned")]
    public int ExtensionInterfaceOwnedDispatch() => ExtensionOperations.InterfaceOwnedDispatch();

    [Benchmark(Baseline = true), BenchmarkCategory("dispatch-base-interface")]
    public int NominalBaseInterfaceDispatch() => OrdinaryOperations.BaseInterfaceDispatch();

    [Benchmark, BenchmarkCategory("dispatch-base-interface")]
    public int ExtensionBaseInterfaceDispatch() => ExtensionOperations.BaseInterfaceDispatch();

    [Benchmark(Baseline = true), BenchmarkCategory("dispatch-delegate")]
    public int NominalDelegateDispatch() => OrdinaryOperations.DelegateDispatch();

    [Benchmark, BenchmarkCategory("dispatch-delegate")]
    public int ExtensionDelegateDispatch() => ExtensionOperations.DelegateDispatch();

    [Benchmark(Baseline = true), BenchmarkCategory("array-store")]
    public int NominalArrayStore() => OrdinaryOperations.ArrayStore();

    [Benchmark, BenchmarkCategory("array-store")]
    public int ExtensionArrayStore() => ExtensionOperations.ArrayStore();

    [Benchmark(Baseline = true), BenchmarkCategory("dispatch-boxed-value-get")]
    public int NominalBoxedValueGet() => OrdinaryOperations.BoxedValueGet();

    [Benchmark, BenchmarkCategory("dispatch-boxed-value-get")]
    public int ExtensionBoxedValueGet() => ExtensionOperations.BoxedValueGet();

    [Benchmark(Baseline = true), BenchmarkCategory("dispatch-boxed-value-increment")]
    public int NominalBoxedValueIncrement() => OrdinaryOperations.BoxedValueIncrement();

    [Benchmark, BenchmarkCategory("dispatch-boxed-value-increment")]
    public int ExtensionBoxedValueIncrement() => ExtensionOperations.BoxedValueIncrement();

    [Benchmark(Baseline = true), BenchmarkCategory("exact-devirtualization")]
    public int NominalExactDevirtualization() => OrdinaryOperations.ExactDevirtualization();

    [Benchmark, BenchmarkCategory("exact-devirtualization")]
    public int ExtensionExactDevirtualization() => ExtensionOperations.ExactDevirtualization();

    [Benchmark(Baseline = true), BenchmarkCategory("constraint-reference")]
    public int NominalReferenceConstraint() => OrdinaryOperations.ReferenceConstraint();

    [Benchmark, BenchmarkCategory("constraint-reference")]
    public int ExtensionReferenceConstraint() => ExtensionOperations.ReferenceConstraint();

    [Benchmark(Baseline = true), BenchmarkCategory("constraint-value")]
    public int NominalValueConstraint() => OrdinaryOperations.ValueConstraint();

    [Benchmark, BenchmarkCategory("constraint-value")]
    public int ExtensionValueConstraint() => ExtensionOperations.ValueConstraint();

    [Benchmark(Baseline = true), BenchmarkCategory("constraint-generic-value")]
    public int NominalGenericValueConstraint() => OrdinaryOperations.GenericValueConstraint();

    [Benchmark, BenchmarkCategory("constraint-generic-value")]
    public int ExtensionGenericValueConstraint() => ExtensionOperations.GenericValueConstraint();

    [Benchmark(Baseline = true), BenchmarkCategory("constraint-static-value")]
    public int NominalStaticValueConstraint() => OrdinaryOperations.StaticValueConstraint();

    [Benchmark, BenchmarkCategory("constraint-static-value")]
    public int ExtensionStaticValueConstraint() => ExtensionOperations.StaticValueConstraint();

    [Benchmark(Baseline = true), BenchmarkCategory("constraint-static-reference")]
    public int NominalStaticReferenceConstraint() => OrdinaryOperations.StaticReferenceConstraint();

    [Benchmark, BenchmarkCategory("constraint-static-reference")]
    public int ExtensionStaticReferenceConstraint() => ExtensionOperations.StaticReferenceConstraint();

    [Benchmark(Baseline = true), BenchmarkCategory("conditional-positive-dispatch")]
    public int NominalConditionalPositiveDispatch() => OrdinaryOperations.ConditionalPositiveDispatch();

    [Benchmark, BenchmarkCategory("conditional-positive-dispatch")]
    public int ExtensionConditionalPositiveDispatch() => ExtensionOperations.ConditionalPositiveDispatch();

    [Benchmark(Baseline = true), BenchmarkCategory("conditional-negative-cast")]
    public bool NominalConditionalNegativeCast() => OrdinaryOperations.ConditionalNegativeCast();

    [Benchmark, BenchmarkCategory("conditional-negative-cast")]
    public bool ExtensionConditionalNegativeCast() => ExtensionOperations.ConditionalNegativeCast();

    [Benchmark(Baseline = true), BenchmarkCategory("reflection-is-assignable")]
    public bool NominalReflectionIsAssignable() => OrdinaryOperations.ReflectionIsAssignable();

    [Benchmark, BenchmarkCategory("reflection-is-assignable")]
    public bool ExtensionReflectionIsAssignable() => ExtensionOperations.ReflectionIsAssignable();

    [Benchmark(Baseline = true), BenchmarkCategory("reflection-interface-map")]
    public int NominalReflectionInterfaceMap() => OrdinaryOperations.ReflectionInterfaceMap();

    [Benchmark, BenchmarkCategory("reflection-interface-map")]
    public int ExtensionReflectionInterfaceMap() => ExtensionOperations.ReflectionInterfaceMap();
}
#endif

public enum OrdinaryColdScenario
{
    InheritedPositive,
    Negative,
}

[MemoryDiagnoser]
public class OrdinaryColdBenchmarks
{
    private const int TypeCount = 64;
    private object[] _values = null!;
    private Func<object, bool> _predicate = null!;

    [ParamsAllValues]
    public OrdinaryColdScenario Scenario { get; set; }

    [IterationSetup]
    public void Setup()
    {
        if (Scenario == OrdinaryColdScenario.InheritedPositive)
        {
            _values = DynamicReceivers.CreateDerivedInstances(typeof(NominalReferenceTarget), TypeCount, "NominalPositive");
            _predicate = static value => value is INominalReference;
            _predicate(new NominalReferenceTarget(1));
        }
        else
        {
            _values = DynamicReceivers.CreatePlainInstances(TypeCount, "NominalNegative");
            _predicate = static value => value is INominalReference;
            _predicate(new NominalNegativeTarget());
        }
    }

    [Benchmark(OperationsPerInvoke = TypeCount)]
    public int ResolveFreshPairs() => DynamicReceivers.CountMatches(_values, _predicate);
}

#if EXTENSION_INTERFACE
public enum ExtensionColdScenario
{
    TypeOwnedInherited,
    InterfaceOwnedGeneric,
    ConditionalRecursivePositive,
    ConditionalNegative,
    GenericValueRecursivePositive,
}

[MemoryDiagnoser]
public class ExtensionColdBenchmarks
{
    private const int TypeCount = 64;
    private object[] _values = null!;
    private Func<object, bool> _predicate = null!;

    [ParamsAllValues]
    public ExtensionColdScenario Scenario { get; set; }

    [IterationSetup]
    public void Setup()
    {
        switch (Scenario)
        {
            case ExtensionColdScenario.TypeOwnedInherited:
                _values = DynamicReceivers.CreateDerivedInstances(typeof(TypeOwnedTarget), TypeCount, "TypeOwned");
                _predicate = static value => value is ITypeOwned;
                _predicate(new TypeOwnedTarget(1));
                break;
            case ExtensionColdScenario.InterfaceOwnedGeneric:
                _values = DynamicReceivers.CreatePlainInstances(TypeCount, "InterfaceOwned");
                _predicate = static value => value is IInterfaceOwned;
                _predicate("warmup");
                break;
            case ExtensionColdScenario.ConditionalRecursivePositive:
                Type[] positiveArguments = DynamicReceivers.CreateDerivedTypes(typeof(TypeOwnedTarget), TypeCount, "ConditionalPositiveArgument");
                _values = DynamicReceivers.CreateClosedGenericInstances(typeof(ConditionalTarget<>), positiveArguments);
                _predicate = static value => value is IConditional;
                _predicate(new ConditionalTarget<TypeOwnedTarget>());
                break;
            case ExtensionColdScenario.ConditionalNegative:
                Type[] negativeArguments = DynamicReceivers.CreatePlainTypes(TypeCount, "ConditionalNegativeArgument");
                _values = DynamicReceivers.CreateClosedGenericInstances(typeof(ConditionalTarget<>), negativeArguments);
                _predicate = static value => value is IConditional;
                _predicate(new ConditionalTarget<string>());
                break;
            case ExtensionColdScenario.GenericValueRecursivePositive:
                Type[] genericValueArguments = DynamicReceivers.CreateDerivedTypes(typeof(TypeOwnedTarget), TypeCount, "GenericValueArgument");
                _values = DynamicReceivers.CreateClosedGenericInstances(typeof(GenericValueTarget<>), genericValueArguments);
                _predicate = static value => value is IValueOwned;
                _predicate(new GenericValueTarget<TypeOwnedTarget>());
                break;
            default:
                throw new InvalidOperationException();
        }
    }

    [Benchmark(OperationsPerInvoke = TypeCount)]
    public int ResolveFreshPairs() => DynamicReceivers.CountMatches(_values, _predicate);
}
#endif

internal static class DynamicReceivers
{
    [MethodImpl(MethodImplOptions.NoInlining)]
    public static int CountMatches(object[] values, Func<object, bool> predicate)
    {
        int matches = 0;
        for (int i = 0; i < values.Length; i++)
        {
            if (predicate(values[i]))
            {
                matches++;
            }
        }
        return matches;
    }

    public static object[] CreateDerivedInstances(Type baseType, int count, string prefix)
    {
        Type[] types = CreateDerivedTypes(baseType, count, prefix);
        var instances = new object[count];
        for (int i = 0; i < instances.Length; i++)
        {
            instances[i] = Activator.CreateInstance(types[i], 1)!;
        }
        return instances;
    }

    public static Type[] CreateDerivedTypes(Type baseType, int count, string prefix)
    {
        ModuleBuilder module = CreateDynamicModule(prefix);
        ConstructorInfo baseConstructor = baseType.GetConstructor(new[] { typeof(int) })!;
        var types = new Type[count];

        for (int i = 0; i < types.Length; i++)
        {
            TypeBuilder builder = module.DefineType($"{prefix}_{i}", TypeAttributes.Public | TypeAttributes.Sealed, baseType);
            ConstructorBuilder constructor = builder.DefineConstructor(MethodAttributes.Public, CallingConventions.Standard, new[] { typeof(int) });
            ILGenerator il = constructor.GetILGenerator();
            il.Emit(OpCodes.Ldarg_0);
            il.Emit(OpCodes.Ldarg_1);
            il.Emit(OpCodes.Call, baseConstructor);
            il.Emit(OpCodes.Ret);
            types[i] = builder.CreateType()!;
        }

        return types;
    }

    public static object[] CreatePlainInstances(int count, string prefix)
    {
        Type[] types = CreatePlainTypes(count, prefix);
        var instances = new object[count];
        for (int i = 0; i < instances.Length; i++)
        {
            instances[i] = Activator.CreateInstance(types[i])!;
        }
        return instances;
    }

    public static Type[] CreatePlainTypes(int count, string prefix)
    {
        ModuleBuilder module = CreateDynamicModule(prefix);
        var types = new Type[count];
        for (int i = 0; i < types.Length; i++)
        {
            TypeBuilder builder = module.DefineType($"{prefix}_{i}", TypeAttributes.Public | TypeAttributes.Sealed);
            builder.DefineDefaultConstructor(MethodAttributes.Public);
            types[i] = builder.CreateType()!;
        }
        return types;
    }

    public static object[] CreateClosedGenericInstances(Type genericType, Type[] arguments)
    {
        var instances = new object[arguments.Length];
        for (int i = 0; i < instances.Length; i++)
        {
            instances[i] = Activator.CreateInstance(genericType.MakeGenericType(arguments[i]))!;
        }
        return instances;
    }

    private static ModuleBuilder CreateDynamicModule(string prefix)
    {
        var name = new AssemblyName($"ExtensionInterfaceBenchmark_{prefix}_{Guid.NewGuid():N}");
        return AssemblyBuilder.DefineDynamicAssembly(name, AssemblyBuilderAccess.Run).DefineDynamicModule(name.Name!);
    }
}
