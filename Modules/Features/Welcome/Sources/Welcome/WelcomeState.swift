//
//  WelcomeState.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import SignIn
import SignUp

extension Welcome {
    public struct State: Equatable {
        
        var signIn: SignIn.State = .initial
        var signUp: SignUp.State = .initial
        
        public static let initial = Self()
        
        public init() {}
    }
}

