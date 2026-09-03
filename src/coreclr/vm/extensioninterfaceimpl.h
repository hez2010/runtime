// Licensed to the .NET Foundation under one or more agreements.
// The .NET Foundation licenses this file to you under the MIT license.

#ifndef _EXTENSIONINTERFACEIMPL_H_
#define _EXTENSIONINTERFACEIMPL_H_

class MethodTable;

namespace ExtensionInterface
{
    void Initialize();

    // Set immutable participation flags while a MethodTable is being built.
    void SetMethodTableFlags(MethodTable* pMT);

    bool IsExtensionSensitive(MethodTable* pReceiverMT, MethodTable* pInterfaceMT);
    bool IsWitnessForReceiver(MethodTable* pReceiverMT, MethodTable* pWitnessMT);

    // Returns the closed witness interface for an extension implementation. Nominal
    // implementations are deliberately not returned by this operation.
    bool TryResolve(MethodTable* pReceiverMT, MethodTable* pInterfaceMT, MethodTable** ppWitnessMT);
}

#endif // _EXTENSIONINTERFACEIMPL_H_
