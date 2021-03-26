//
//  File.swift
//  
//
//  Created by Sergey Pugach on 18.03.21.
//

import Foundation
import Combine

public protocol Authenticatable {
    func createUser(email: String, password: String) -> AnyPublisher<User, Error>
}


