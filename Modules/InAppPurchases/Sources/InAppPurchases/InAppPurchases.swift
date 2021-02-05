//
//  File.swift
//  
//
//  Created by Sergey Pugach on 31.01.21.
//

import Purchases
import Combine

public struct InAppPurchases {
    
    private enum Key {
        static let release = "vgiOtOfdnckQGgaLCsGWrpvDhRTGFyVQ"
        static let beta = "SGMXaLgsWsYvjKMmQUUAYVfZFuKZIaQS"
        static let `default` = release
    }
    
    private let purchase: Purchases
    
    //userID    String    "c1ef0e47-9706-4b5e-ad8c-22ad42890009"
    public init() {
        Purchases.debugLogsEnabled = true
        purchase = Purchases.configure(withAPIKey: Key.default)
        _ = configure().sink(receiveCompletion: { _ in }, receiveValue: {})
    }
}


// MARK: - InAppPurchasable

extension InAppPurchases: InAppPurchasable {
    
    public func currentPackages() -> AnyPublisher<[Package], PurchasesError> {
        currentOffering()
            .tryMap({ (offering: Offering?) -> [Package] in
                guard let packages = offering?.availablePackages else {
                    throw PurchasesError.packagesIsEmpty
                }
                return packages
            })
            .mapError(PurchasesError.init)
            .eraseToAnyPublisher()
    }
}


// MARK: - Methods

private extension InAppPurchases {
    
    func configure() -> AnyPublisher<Void, PurchasesError> {
        Future { promise in
            purchase.identify("c1ef0e47-9706-4b5e-ad8c-22ad42890009") { (info: Purchases.PurchaserInfo?, error: Error?) in
                if let error = error {
                    promise(.failure(PurchasesError.other(error)))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func offerings() -> AnyPublisher<Offerings?, Error> {
        Future { promise in
            purchase.offerings { (offerings: Purchases.Offerings?, error: Error?) in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(offerings))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func currentOffering() -> AnyPublisher<Offering?, Error> {
        offerings()
            .map({ (offerings: Offerings?) -> Offering? in
                return offerings?.current
            })
            .eraseToAnyPublisher()
    }
}

private extension PurchasesError {
    init(_ error: Error) {
        self = .other(error)
    }
}

