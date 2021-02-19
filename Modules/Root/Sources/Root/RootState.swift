//
//  File.swift
//  
//
//  Created by Sergey Pugach on 8.02.21.
//

import Foundation
import Profile

extension Root {
    public struct State: Equatable {
        
        var profile: Profile.State
        
        public static let initial = Self(
            profile: .initial
        )
        
        public init(profile: Profile.State) {
            self.profile = profile
        }
    }
}
