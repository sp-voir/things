//
//  IdentifiableBox.swift
//  
//
//  Created by Sergey Pugach on 5.01.21.
//

@dynamicMemberLookup
@propertyWrapper
public struct IdentifiableBox<Content: Hashable>: Identifiable {
    public var id: Int { content.hashValue }
    public var content: Content
    
    public var wrappedValue: Content {
        get { content }
        set { content = newValue }
    }
    
    public var projectedValue: Int { id }
    
    public init(wrappedValue: Content) {
        self.init(wrappedValue)
    }
    
    public init(_ content: Content) {
        self.content = content
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Content, T>) -> T {
        get { content[keyPath: keyPath] }
    }

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Content, T>) -> T {
        get { content[keyPath: keyPath] }
        set { content[keyPath: keyPath] = newValue }
    }
}

extension IdentifiableBox: ExpressibleByUnicodeScalarLiteral where Content: ExpressibleByUnicodeScalarLiteral {
    public init(unicodeScalarLiteral value: Content.UnicodeScalarLiteralType) {
        self.content = .init(unicodeScalarLiteral: value)
    }
}

extension IdentifiableBox: ExpressibleByExtendedGraphemeClusterLiteral where Content: ExpressibleByExtendedGraphemeClusterLiteral {
    public init(extendedGraphemeClusterLiteral value: Content.ExtendedGraphemeClusterLiteralType) {
        self.content = .init(extendedGraphemeClusterLiteral: value)
    }
}

extension IdentifiableBox: ExpressibleByStringLiteral where Content: ExpressibleByStringLiteral {
    public init(stringLiteral value: Content.StringLiteralType) {
        self.content = .init(stringLiteral: value)
    }
}

extension IdentifiableBox: ExpressibleByIntegerLiteral where Content: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Content.IntegerLiteralType) {
        self.content = .init(integerLiteral: value)
    }
}

extension IdentifiableBox: ExpressibleByBooleanLiteral where Content: ExpressibleByBooleanLiteral {
    public init(booleanLiteral value: Content.BooleanLiteralType) {
        self.content = .init(booleanLiteral: value)
    }
}
