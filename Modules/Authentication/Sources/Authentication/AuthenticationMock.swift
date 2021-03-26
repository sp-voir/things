//
//  File.swift
//  
//
//  Created by Sergey Pugach on 18.03.21.
//

import Foundation
import Combine

final class AuthenticationMock: Authenticatable {

    enum MockError: Swift.Error {
        case generic
    }
    
    func createUser(email: String, password: String) -> AnyPublisher<User, Error> {
        return Fail(error: MockError.generic)
            .delay(for: .seconds(1), scheduler: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
