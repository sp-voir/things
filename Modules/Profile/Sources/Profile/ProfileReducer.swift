//
//  ProfileReducer.swift
//  VoirCam
//
//  Created by Sergey Pugach on 10.02.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation
import ComposableArchitectureApp

extension Profile {
    public static let reducer = Reducer<State, Action, Environment>.init { (state: inout State, action: Action, environment: Environment) -> Effect<Action, Never> in
        return .none
    }
}
