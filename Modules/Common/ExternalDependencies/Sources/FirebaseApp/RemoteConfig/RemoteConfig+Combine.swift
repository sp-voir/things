//
//  RemoteConfig+Combine.swift
//  
//
//  Created by Sergey Pugach on 27.01.21.
//

import Combine
import FirebaseRemoteConfig

extension RemoteConfig {
    
    public func fetchAndActivate() -> AnyPublisher<RemoteConfigFetchAndActivateStatus, Error> {
        Future<RemoteConfigFetchAndActivateStatus, Error> { [weak self] promise in
            self?.fetchAndActivate { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func fetch(activateFetched: Bool = false) -> AnyPublisher<RemoteConfigFetchStatus, Error> {
        Future<RemoteConfigFetchStatus, Error> { [weak self] promise in
            self?.fetch { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    if activateFetched, result == .success {
                        self?.activate { _, _ in }
                    }
                    promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func fetch(withExpirationDuration duration: TimeInterval, activateFetched: Bool = false) -> AnyPublisher<RemoteConfigFetchStatus, Error> {
        Future<RemoteConfigFetchStatus, Error> { [weak self] promise in
            self?.fetch(withExpirationDuration: duration) { result, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    if activateFetched, result == .success {
                        self?.activate{ _, _ in }
                    }
                    promise(.success(result))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    public func activate() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.activate { _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }.eraseToAnyPublisher()
    }
    
}
