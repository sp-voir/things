//
//  SignInState.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation

extension SignIn {
    public struct State: Equatable {
        
        @Validation var email: String = ""
        var password: String = ""
        
        public static let initial = Self()
        
        public init() {}
    }
}

extension SignIn.State {
    
    var isValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
}


@propertyWrapper
public struct Validation: Equatable {
    
    enum ValidationError: Swift.Error {
        case short, noDigits, noCharacters
    }
    
    private var value: String = ""
    
    public var wrappedValue: String {
        get { value }
        set { value = newValue }
    }
    
    public init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
}
