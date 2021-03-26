//
//  SignInAction.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation

extension SignIn {
    public enum Action: Equatable {
        case emailChanged(String)
        case passwordChanged(String)
    }
}
