//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}

extension MutableCollection {
    public subscript(safe index: Index) -> Element? {
        get {
            guard indices.contains(index) else { return nil }
            return self[index]
        }
        set {
            guard indices.contains(index), let value = newValue else { return  }
            self[index] = value
        }
    }
}
