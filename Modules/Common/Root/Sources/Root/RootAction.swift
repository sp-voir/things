//
//  File.swift
//  
//
//  Created by Sergey Pugach on 8.02.21.
//

import Foundation
import Profile

extension Root {
    public enum Action: Equatable {
        case profile(Profile.Action)
    }
}
