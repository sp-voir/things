//
//  File.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import RemoteConfiguration
import InAppPurchases

extension PaywallV1 {
    public struct Environment {
        let remoteConfiguration: RemoteConfigurable
        let purchases: InAppPurchasable
        
        public init(
            remoteConfiguration: RemoteConfigurable,
            purchases: InAppPurchasable
        ) {
            self.remoteConfiguration = remoteConfiguration
            self.purchases = purchases
        }
    }
}
