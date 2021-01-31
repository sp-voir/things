//
//  File.swift
//  
//
//  Created by Sergey Pugach on 31.01.21.
//

import Purchases

@dynamicMemberLookup
public struct Package {
    public typealias Period = Purchases.PackageType
    
    public var identifier: String?
    public let product: SKProduct
    public let discount: ProductDiscount?
    
    public init(package: Purchases.Package) {
        self.init(product: package.product)
        self.identifier = package.identifier
    }
    
    public init(product: SKProduct) {
        self.product = product
        self.discount = product.introductoryPrice.flatMap(ProductDiscount.init)
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<SKProduct, T>) -> T {
        product[keyPath: keyPath]
    }
}
