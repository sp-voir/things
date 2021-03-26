//
//  PaywallV1State.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

extension PaywallV1 {
    public struct State: Equatable {
        
        var isLoading: Bool
        
        public static let initial: Self = .init(
            isLoading: false
        )
    }
}
