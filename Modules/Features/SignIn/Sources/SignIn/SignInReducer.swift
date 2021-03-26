//
//  SignInReducer.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import ComposableArchitectureApp

extension SignIn {
    public static let reducer = Reducer<State, Action, Environment> { (state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> in
        switch action {
        case let .emailChanged(text):
            state.email = text
            return .none
        case let .passwordChanged(text):
            state.password = text
            return .none
        }
    }
}
