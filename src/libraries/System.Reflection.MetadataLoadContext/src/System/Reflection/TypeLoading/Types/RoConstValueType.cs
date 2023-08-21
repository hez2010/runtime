// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

using System.Collections.Generic;
using System.Diagnostics.CodeAnalysis;
using System.Linq;
using System.Runtime.InteropServices;

namespace System.Reflection.TypeLoading
{
    internal sealed class RoConstValueType : RoType
    {
        private readonly RoModule _module;
        private readonly object? _value;
        private readonly RoType _type;
        internal RoConstValueType(RoModule module, object? value, RoType type)
        {
            _module = module;
            _value = value;
            _type = type;
        }

        public override bool IsTypeDefinition => false;

        public override bool IsGenericTypeDefinition => false;

        public override bool IsSZArray => false;

        public override bool IsVariableBoundArray => false;

        public override bool IsConstructedGenericType => false;

        public override bool IsGenericParameter => false;

        public override bool IsGenericTypeParameter => false;

        public override bool IsGenericMethodParameter => false;

        public override bool IsFunctionPointer => false;

        public override bool IsUnmanagedFunctionPointer => false;

        public override bool ContainsGenericParameters => false;
        public override bool IsConstValue => true;
        public override object? ConstValue => _value;

        public override GenericParameterAttributes GenericParameterAttributes => GenericParameterAttributes.None;

        public override int GenericParameterPosition => 0;

        public override MethodBase? DeclaringMethod => null;

        public override IEnumerable<CustomAttributeData> CustomAttributes => Enumerable.Empty<CustomAttributeData>();

        public override int MetadataToken => 0;

        public override Guid GUID => Guid.Empty;

        public override StructLayoutAttribute? StructLayoutAttribute => null;

        public override int GetArrayRank() => throw new NotImplementedException();
        public override Type[] GetFunctionPointerParameterTypes() => throw new NotImplementedException();
        public override Type GetFunctionPointerReturnType() => throw new NotImplementedException();
        public override Type[] GetGenericParameterConstraints() => throw new NotImplementedException();
        public override Type GetGenericTypeDefinition() => throw new NotImplementedException();
        [RequiresUnreferencedCode("If some of the generic arguments are annotated (either with DynamicallyAccessedMembersAttribute, or generic constraints), trimming can't validate that the requirements of those annotations are met.")]
        public override Type MakeGenericType(params Type[] typeArguments) => throw new NotImplementedException();
        public override string ToString() => throw new NotImplementedException();
        protected override TypeAttributes ComputeAttributeFlags() => throw new NotImplementedException();
        protected override RoType? ComputeDeclaringType() => throw new NotImplementedException();
        protected override string? ComputeFullName() => throw new NotImplementedException();
        protected override string ComputeName() => throw new NotImplementedException();
        protected override string? ComputeNamespace() => throw new NotImplementedException();
        protected override TypeCode GetTypeCodeImpl() => throw new NotImplementedException();
        protected override bool HasElementTypeImpl() => true;
        protected override bool IsArrayImpl() => false;
        protected override bool IsByRefImpl() => false;
        protected override bool IsPointerImpl() => false;
        protected internal override RoType ComputeEnumUnderlyingType() => throw new NotImplementedException();
        protected internal override RoType[] GetGenericArgumentsNoCopy() => throw new NotImplementedException();
        internal override RoType? ComputeBaseTypeWithoutDesktopQuirk() => null;
        internal override IEnumerable<RoType> ComputeDirectlyImplementedInterfaces() => Enumerable.Empty<RoType>();
        internal override IEnumerable<ConstructorInfo> GetConstructorsCore(NameFilter? filter) => Enumerable.Empty<ConstructorInfo>();
        internal override IEnumerable<EventInfo> GetEventsCore(NameFilter? filter, Type reflectedType) => Enumerable.Empty<EventInfo>();
        internal override IEnumerable<FieldInfo> GetFieldsCore(NameFilter? filter, Type reflectedType) => Enumerable.Empty<FieldInfo>();
        internal override RoType[] GetGenericTypeArgumentsNoCopy() => throw new NotImplementedException();
        internal override RoType[] GetGenericTypeParametersNoCopy() => throw new NotImplementedException();
        internal override IEnumerable<MethodInfo> GetMethodsCore(NameFilter? filter, Type reflectedType) => Enumerable.Empty<MethodInfo>();
        internal override IEnumerable<RoType> GetNestedTypesCore(NameFilter? filter) => Enumerable.Empty<RoType>();
        internal override IEnumerable<PropertyInfo> GetPropertiesCore(NameFilter? filter, Type reflectedType) => Enumerable.Empty<PropertyInfo>();
        internal override RoType? GetRoElementType() => _type;
        internal override RoModule GetRoModule() => _module;
        internal override bool IsCustomAttributeDefined(ReadOnlySpan<byte> ns, ReadOnlySpan<byte> name) => false;
        internal override CustomAttributeData? TryFindCustomAttribute(ReadOnlySpan<byte> ns, ReadOnlySpan<byte> name) => null;
    }
}
