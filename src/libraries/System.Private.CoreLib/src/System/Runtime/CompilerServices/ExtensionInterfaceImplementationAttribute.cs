// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System.ComponentModel;

namespace System.Runtime.CompilerServices
{
    /// <summary>
    /// Marks a compiler-generated interface that supplies an extension interface implementation.
    /// </summary>
    /// <remarks>
    /// This attribute is reserved for compilers. A validated extension-interface manifest entry is
    /// also required; applying this attribute does not make a type an implementation witness.
    /// </remarks>
    [EditorBrowsable(EditorBrowsableState.Never)]
    [AttributeUsage(AttributeTargets.Interface, Inherited = false)]
    public sealed class ExtensionInterfaceImplementationAttribute : Attribute
    {
        /// <summary>Initializes the attribute.</summary>
        public ExtensionInterfaceImplementationAttribute()
        {
        }
    }
}
