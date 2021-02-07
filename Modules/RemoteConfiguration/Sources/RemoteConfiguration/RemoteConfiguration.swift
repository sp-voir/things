//
//  RemoteConfiguration.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import FirebaseApp
import Combine
import CombineExt

public struct RemoteConfiguration: RemoteConfigurable {
    
    public let mainPaywallConfig = CurrentValueRelay<PaywallConfig>(.default)
    
    private enum Property {
        static let mainPaywall = "main_paywall"
    }
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    //public let fetch1: (AnyHashable) -> Effect<RemoteConfigFetchStatus, Error>
    
    public init() {
    }
    
    public func fetch() -> AnyPublisher<RemoteConfigFetchStatus, RemoteConfigError> {
        return remoteConfig
            .fetch(activateFetched: true)
            .handleEvents(receiveOutput: { status in
                let data = self.remoteConfig.configValue(forKey: Property.mainPaywall).dataValue
                let decoder = JSONDecoder()
                
                guard let paywallConfig = try? decoder.decode(PaywallConfig.self, from: data) else {
                    return
                }
                mainPaywallConfig.accept(paywallConfig)
            })
            .mapError(RemoteConfigError.init)
            .eraseToAnyPublisher()
    }
}

extension RemoteConfigurable {
    
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
//
//private var dependencies: [AnyHashable: RemoteConfig] = [:]

private extension RemoteConfigError {
    init(_ error: Error) {
        self = .other(error)
    }
}
