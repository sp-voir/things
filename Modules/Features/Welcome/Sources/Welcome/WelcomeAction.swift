//
//  WelcomeAction.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import SignIn
import SignUp

extension Welcome {
    public enum Action: Equatable {
        case signIn(SignIn.Action)
        case signUp(SignUp.Action)
    }
}
