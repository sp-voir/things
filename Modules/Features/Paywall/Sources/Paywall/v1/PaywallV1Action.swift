//
//  PaywallV1Action.swift
//  
//
//  Created by Sergey Pugach on 28.01.21.
//

import InAppPurchases

extension PaywallV1 {
    public enum Action: Equatable {
        case fetching
        case fetched
        case getCurrentPackages
        case currentPackages([Package])
        case loadPackagesFailed(PurchasesError)
    }
}

extension PurchasesError: Equatable {
    public static func == (lhs: PurchasesError, rhs: PurchasesError) -> Bool {
        switch (lhs, rhs) {
        case (.packagesIsEmpty, .packagesIsEmpty):
            return true
        case let (.other(lhs), .other(rhs)):
            return lhs.localizedDescription == rhs.localizedDescription
        default:
            return false
        }
    }
}
