//
//  PaywallV1Reducer.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import ComposableArchitecture

extension PaywallV1 {
    
    public static let reducer = Reducer<State, Action, Environment> { state, action, environment -> Effect<Action, Never> in
        switch action {
        case .fetching:
            state.isLoading = true
            struct RecorderId: Hashable {}
            return environment.remoteConfiguration.fetch()//.fetch(RecorderId()
                .catchToEffect()
                .map({ _ in Action.fetched })
            
        case .fetched:
            state.isLoading = false
            return .none
        }
    }
}
