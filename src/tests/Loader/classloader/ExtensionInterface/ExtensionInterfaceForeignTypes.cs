// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

public interface IForeignOrdinaryClass { }
public interface IForeignOrdinaryStruct { }
public interface IForeignGeneric<T> { }
public interface IForeignConditional<T> { }
public interface IForeignNested<T> { }
public interface IForeignMethodConstraint { }
public interface IForeignGenericMethod
{
    TMethod Invoke<TMethod>(TMethod value);
    TMethod InvokeConstrained<TMethod>(TMethod value) where TMethod : IForeignMethodConstraint;
}
public interface IForeignGenericTypeMethod<TContext>
{
    TMethod Invoke<TMethod>(TContext context, TMethod value);
}

public sealed class ForeignOrdinaryClass { }

public struct ForeignOrdinaryStruct
{
    public int Value;
}

public sealed class ForeignGenericClass<T> { }

public struct ForeignGenericStruct<T>
{
    public T Value;
}

public sealed class ForeignConditionalClass<T> { }
public sealed class ForeignNestedClass<T> { }
public sealed class ForeignGenericMethodClass { }
public struct ForeignGenericMethodStruct { }
public sealed class ForeignGenericTypeMethodClass<TContext> { }
