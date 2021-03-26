//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

extension Optional {
    
    @inlinable
    public var isNotNil: Bool { !isNil }
    
    @inlinable
    public var isNil: Bool {
        switch self {
        case .none: return true
        case .some: return false
        }
    }
    
    @inlinable
    public func or(_ value: @autoclosure () -> Wrapped) -> Wrapped {
        self ?? value()
    }
    
    @inlinable
    public func or(_ value: @autoclosure () -> Wrapped?) -> Wrapped? {
        self ?? value()
    }
    
    @inlinable
    public func unwrap() -> Result<Wrapped, UnwrappingError<Wrapped>> {
        switch self {
        case .some(let value):
            return .success(value)
        case .none:
            return .failure(UnwrappingError(Wrapped.self))
        }
    }
    
    @inlinable
    public func assign<T>(
        to keyPath: ReferenceWritableKeyPath<T, Wrapped>, on target: T
    ) { map { target[keyPath: keyPath] = $0 } }
    
    @inlinable
    public func assign<T>(
        to keyPath: ReferenceWritableKeyPath<T, Optional>, on target: T
    ) { target[keyPath: keyPath] = self }
    
}

extension Optional where Wrapped: AnyObject {
    public func middleware(_ transform: (Wrapped) throws -> Void) rethrows -> Self {
        try map(transform)
        return self
    }
}

extension Optional where Wrapped: Collection {
    
    public var isEmptyOrNil: Bool {
        switch self {
        case .some(let collection):
            return collection.isEmpty
        case .none:
            return false
        }
    }
}
