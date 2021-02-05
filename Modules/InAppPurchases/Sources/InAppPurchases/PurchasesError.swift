//
//  File.swift
//  
//
//  Created by Sergey Pugach on 3.02.21.
//

import Foundation

public enum PurchasesError: Swift.Error {
    case packagesIsEmpty
    case other(Error) //Add normal cases instead of `other`
}
