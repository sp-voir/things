//
//  File.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import RemoteConfiguration

extension PaywallV1 {
    public struct Environment {
        let remoteConfiguration: RemoteConfigurable
        
        public init(remoteConfiguration: RemoteConfigurable) {
            self.remoteConfiguration = remoteConfiguration
        }
    }
}
