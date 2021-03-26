//
//  File.swift
//  
//
//  Created by Sergey Pugach on 18.03.21.
//

import Foundation
import FirebaseApp
import Combine

public struct Authentication {
    
    private let auth = Auth.auth()
    
    //public let test2: (String) -> (AnyPublisher<Void, Never>)
    //public init() {}
}


// MARK: - Authenticatable

extension Authentication: Authenticatable {
    
    public static let live: Authenticatable = Authentication()
    public static let mock: Authenticatable = AuthenticationMock()
    
    public func createUser(email: String, password: String) -> AnyPublisher<User, Error> {
//        return Just(())
//            .delay(for: .seconds(2), scheduler: DispatchQueue.main)
//            .setFailureType(to: Error.self)
//            .eraseToAnyPublisher()
        
        return auth.createUser(withEmail: email, password: password)
            .handleEvents(receiveSubscription: { (_) in
                print("-_- will createUser")
            }, receiveOutput: { _ in
                print("-_- did createUser")
            }, receiveCompletion: { (comp) in
                print("-_- comp: \(comp)")
            })
            .map(User.init(from:))
            .eraseToAnyPublisher()
    }
    
//    public static let mock = Authentication(
//        test2: { value in
//            return Just(()).eraseToAnyPublisher()
//        }
//    )
}

private extension User {
    
    init(from authData: AuthDataResult) {
        self.init(user: authData.user)
    }
}
