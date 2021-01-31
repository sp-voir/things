//
//  File.swift
//  
//
//  Created by Sergey Pugach on 31.01.21.
//

import Purchases

struct InAppPurchases {
    
    enum Key {
        static let release = "vgiOtOfdnckQGgaLCsGWrpvDhRTGFyVQ"
        static let beta = "SGMXaLgsWsYvjKMmQUUAYVfZFuKZIaQS"
        static let `default` = release
    }
    
    let purchase: Purchases
    
    init() {
        purchase = Purchases.configure(withAPIKey: Key.default)
    }
    
    func test() {
    }
}

