//
//  SignUpReducer.swift
//  Things
//
//  Created by Sergey Pugach on 18.03.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import ComposableArchitectureApp
import Authentication

extension SignUp {
    public static let reducer = Reducer<State, Action, Environment> { (state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> in
        switch action {
        case let .emailChanged(email):
            state.email = email
            return .none
            
        case let .passwordChanged(password):
            state.password = password
            return .none
            
        case .signUpTapped:
            return environment.authentication.createUser(email: state.email, password: state.password)
                .catchToEffect()
                .map({ (result: Result<User, Error>) -> Action in
                    switch result {
                    case .success(let user):
                        return .signUpSuccess
                    case .failure(let error):
                        return .alert(error.localizedDescription)
                    }
                })
                .prepend(.isLoading(true))
                .append(.isLoading(false))
                .eraseToEffect()
            
        case .signUpSuccess:
            return Effect<SignUp.Action, Never>.none
                .eraseToEffect()
            
        case let .isLoading(value):
            print("-_- isloading: \(value)")
            state.isLoading = value
            return .none
            
        case let .alert(message):
            state.alertState = AlertState(
                title: TextState("Alert"),
                message:  TextState(message)
            )
            return .none
            
        case .alertDismissed:
            state.alertState = nil
            return .none
        }
    }
}
