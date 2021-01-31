//
//  File.swift
//  
//
//  Created by Sergey Pugach on 31.01.21.
//

import Firebase
import ComposableArchitecture

public struct RemoteConfigurationMock: RemoteConfigurable {
    
    public func fetch() -> Effect<RemoteConfigFetchStatus, Error> {
        return .init(value: .success)
    }
}

extension RemoteConfigurable {
    
    public static var mock: RemoteConfigurable {
        return RemoteConfigurationMock()
    }
    
//    public static let live = RemoteConfiguration(
//        fetch1: { (id) -> Effect<RemoteConfigFetchStatus, Error> in
//            guard let cfg = dependencies[id] else { return .none }
//            return cfg
//                .fetch()
//                .eraseToEffect()
//        })
//
//    public static let mock = RemoteConfiguration(
//        fetch: { (id) -> Effect<RemoteConfigFetchStatus, Error> in
//            return Effect(value: RemoteConfigFetchStatus.success)
//        })
}
