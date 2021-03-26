//
//  SignUpEnvironment.swift
//  Things
//
//  Created by Sergey Pugach on 18.03.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import Foundation
import Authentication

extension SignUp {
    public struct Environment {
        let authentication: Authenticatable
        
        public init(authentication: Authenticatable) {
            self.authentication = authentication
        }
    }
}
