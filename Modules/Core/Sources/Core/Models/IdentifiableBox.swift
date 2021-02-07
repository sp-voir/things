//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import Foundation

@dynamicMemberLookup
@propertyWrapper
public struct IdentifiableBox<Content: Hashable>: Identifiable {
    public var id: Int { content.hashValue }
    public var content: Content
    
    @inlinable
    public var wrappedValue: Content {
        get { content }
        set { content = newValue }
    }
    
    @inlinable
    public var projectedValue: Int { id }
    
    @inlinable
    public init(wrappedValue: Content) {
        self.init(wrappedValue)
    }
    
    @inlinable
    public init(_ content: Content) {
        self.content = content
    }
    
    @inlinable
    public subscript<T>(dynamicMember keyPath: KeyPath<Content, T>) -> T {
        get { content[keyPath: keyPath] }
    }
    
    @inlinable
    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Content, T>) -> T {
        get { content[keyPath: keyPath] }
        set { content[keyPath: keyPath] = newValue }
    }
}
