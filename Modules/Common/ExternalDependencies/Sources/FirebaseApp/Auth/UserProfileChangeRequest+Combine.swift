//
//  File.swift
//  
//
//  Created by Sergey Pugach on 18.03.21.
//

import FirebaseAuth
import Combine

extension UserProfileChangeRequest {
    public func commitChanges() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { [weak self] promise in
            self?.commitChanges(completion: { error in
                guard let error = error else {
                    promise(.success(()))
                    return
                }
                promise(.failure(error))
            })
        }.eraseToAnyPublisher()
    }
}
