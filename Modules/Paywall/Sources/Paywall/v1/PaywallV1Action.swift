//
//  PaywallV1Action.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import InAppPurchases

extension PaywallV1 {
    public enum Action {
        case fetching
        case fetched
        case getCurrentPackages
        case currentPackages([Package])
        case loadPackagesFailed(PurchasesError)
    }
}
