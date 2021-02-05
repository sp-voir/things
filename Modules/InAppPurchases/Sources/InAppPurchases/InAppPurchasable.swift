//
//  File.swift
//  
//
//  Created by Sergey Pugach on 3.02.21.
//

import Combine

public protocol InAppPurchasable {
    func currentPackages() -> AnyPublisher<[Package], PurchasesError>
}
