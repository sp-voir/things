//
//  PaywallV1Reducer.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import Combine
import ComposableArchitecture
import InAppPurchases

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
            return .init(value: .getCurrentPackages)
            
        case .getCurrentPackages:
            state.isLoading = true
            return environment.purchases.currentPackages()
                .map({ Action.currentPackages($0) })
                .catch({ (error: PurchasesError) -> AnyPublisher<Action, Never> in
                    Just(Action.loadPackagesFailed(error))
                        .eraseToAnyPublisher()
                })
                .eraseToEffect()
            
        case let .currentPackages(packages):
            return .none
        case let .loadPackagesFailed(error):
            return .none
        }
    }
}
