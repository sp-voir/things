//
//  File.swift
//  
//
//  Created by Sergey Pugach on 3.02.21.
//

import Combine

struct InAppPurchasesMock: InAppPurchasable {
    
    func currentPackages() -> AnyPublisher<[Package], PurchasesError> {
        return Just(Array.init(repeating: Package(), count: 3))
            .setFailureType(to: PurchasesError.self)
            .eraseToAnyPublisher()
    }
}

extension InAppPurchases {
    public static var mock: InAppPurchasable {
        return InAppPurchasesMock()
    }
}
