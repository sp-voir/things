//
//  SignUpAction.swift
//  Things
//
//  Created by Sergey Pugach on 18.03.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation

extension SignUp {
    public indirect enum Action: Equatable {
        case emailChanged(String)
        case passwordChanged(String)
        case signUpTapped
        case signUpSuccess
        
        case isLoading(Bool)
        case alert(String)
        case alertDismissed
    }
}
