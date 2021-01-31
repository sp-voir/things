//
//  File.swift
//  
//
//  Created by Sergey Pugach on 31.01.21.
//


import FirebaseRemoteConfig
import ComposableArchitecture

public protocol RemoteConfigurable {
    func fetch() -> Effect<RemoteConfigFetchStatus, Error>
}
