//
//  SignUpState.swift
//  Things
//
//  Created by Sergey Pugach on 18.03.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import ComposableArchitectureApp

extension SignUp {
    public struct State: Equatable {
        
        var email = ""
        var password = ""
        var isLoading = false
        var alertState: AlertState<Action>?
        
        public static let initial = Self()
        
        public init() {}
    }
}

extension SignUp.State {
    
    var isValid: Bool {
        return !email.isEmpty && !password.isEmpty
    }
}
