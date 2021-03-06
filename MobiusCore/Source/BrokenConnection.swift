// Copyright (c) 2019 Spotify AB.
//
// Licensed to the Apache Software Foundation (ASF) under one
// or more contributor license agreements.  See the NOTICE file
// distributed with this work for additional information
// regarding copyright ownership.  The ASF licenses this file
// to you under the Apache License, Version 2.0 (the
// "License"); you may not use this file except in compliance
// with the License.  You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the License is distributed on an
// "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
// KIND, either express or implied.  See the License for the
// specific language governing permissions and limitations
// under the License.

import Foundation

/// A helper to construct `Connection`s that will fail when used.
///
/// `BrokenConnection.connection()` is used when functions return `Connection` fail an assertion. The resulting
/// connection will trigger an assertion whenever its `accept` or `dispose` methods are called.
public enum BrokenConnection<Value> {
    static func _accept(_ value: Value) {
        MobiusHooks.onError("'accept' called on invalid connection")
    }

    static func _dispose() {
        MobiusHooks.onError("'dispose' called on invalid connection")
    }

    /// Construct a broken connection.
    ///
    /// The resulting connection will trigger an assertion whenever its `accept` or `dispose` methods are
    /// called.
    public static func connection() -> Connection<Value> {
        return Connection(acceptClosure: _accept, disposeClosure: _dispose)
    }
}
