//
//  WelcomeReducer.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import ComposableArchitectureApp
import SignIn
import SignUp

extension Welcome {
    
    public static let reducer = Reducer<State, Action, Environment>.combine([
        welcomeReducer,
        signInReducer,
        signUpReducer,
    ])
    .debug()
    
    private static let welcomeReducer = Reducer<State, Action, Environment>.init { (state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> in
        
        switch action {
        case let .signIn(signIn):
            return .none
        case let .signUp(signUp):
            switch signUp {
            case .signUpSuccess:
                return .none
            default:
                return .none
            }
        default:
            return .none
        }
    }

    private static let signInReducer = SignIn.reducer
        .pullback(
            state: \Welcome.State.signIn,
            action: /Welcome.Action.signIn,
            environment: { (environment: Welcome.Environment) in
                SignIn.Environment()
            }
        )
    
    private static let signUpReducer = SignUp.reducer
        .pullback(
            state: \Welcome.State.signUp,
            action: /Welcome.Action.signUp,
            environment: { (environment: Welcome.Environment) in
                return SignUp.Environment(
                    authentication: environment.authentication
                )
            }
        )
}
