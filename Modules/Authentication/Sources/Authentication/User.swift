//
//  File.swift
//  
//
//  Created by Sergey Pugach on 19.03.21.
//

import Foundation
import FirebaseAuth

@dynamicMemberLookup
public struct User: Equatable {
//    let uid: String
//    let displayName: String?
//    let photoURL: URL?
//    let email: String?
//    let phoneNumber: String?
//    let anonymous: Bool
//    let emailVerified: Bool
    
    enum CodingKeys: CodingKey {
        case user
    }
    
    private let user: FirebaseAuth.User
    
    public subscript<T>(dynamicMember keyPath: KeyPath<FirebaseAuth.User, T>) -> T {
        user[keyPath: keyPath]
    }
    
    init(user: FirebaseAuth.User) {
        self.user = user
    }
}
