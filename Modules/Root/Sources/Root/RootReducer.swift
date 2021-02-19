//
//  File.swift
//  
//
//  Created by Sergey Pugach on 8.02.21.
//

import Foundation
import ComposableArchitectureApp
import Profile

extension Root {
    
    public static let reducer = Reducer.combine(
        profileReducer,
        rootReducer
    )
    
    private static let rootReducer = Reducer<State, Action, Environment>.init { (state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> in
        switch action {
        case let .profile(profile):
            return .none
        }
    }
    
    private static let profileReducer = Profile.reducer.pullback(
        state: \Root.State.profile,
        action: /Root.Action.profile,
        environment: { (environment: Root.Environment) in
            Profile.Environment()
        }
    )
}
