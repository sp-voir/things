//
//  File.swift
//  
//
//  Created by Sergey Pugach on 31.01.21.
//

import Combine
import FirebaseRemoteConfig


public protocol RemoteConfigurable {
    func fetch() -> AnyPublisher<RemoteConfigFetchStatus, RemoteConfigError>
}
