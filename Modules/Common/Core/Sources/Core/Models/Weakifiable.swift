//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import Foundation

public protocol Weakifiable: AnyObject {}

extension Weakifiable {
    /// Provides a closure with a weak self as a first parameter for non-returning functions
    ///
    /// Usage:
    /// ```
    /// DispatchQueue.main.async(execute: captured { _self in
    ///     _self.titleLabel = "Task has been finished"
    /// }
    /// ```
    public func capture(in closure: @escaping (Self) -> Void)
    -> (() -> Void) { Weak(self).capture(in: closure) }
    
    /// Provides a closure with a weak self as a first parameter for non-returning functions
    ///
    /// Usage:
    /// ```
    /// fetchSomething(completion: captured { _self, result in
    ///     _self.handleFetch(result)
    /// }
    /// ```
    public func capture<T0>(in closure: @escaping (Self, T0) -> Void)
    -> ((T0) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1>(in closure: @escaping (Self, T0, T1) -> Void)
    -> ((T0, T1) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2>(in closure: @escaping (Self, T0, T1, T2) -> Void)
    -> ((T0, T1, T2) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3>(in closure: @escaping (Self, T0, T1, T2, T3) -> Void)
    -> ((T0, T1, T2, T3) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4>(in closure: @escaping (Self, T0, T1, T2, T3, T4) -> Void)
    -> ((T0, T1, T2, T3, T4) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5>(in closure: @escaping (Self, T0, T1, T2, T3, T4, T5) -> Void)
    -> ((T0, T1, T2, T3, T4, T5) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6>(in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6) -> Void)
    -> ((T0, T1, T2, T3, T4, T5, T6) -> Void) { Weak(self).capture(in: closure) }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, T7>(in closure: @escaping (Self, T0, T1, T2, T3, T4, T5, T6, T7) -> Void)
    -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Void) { Weak(self).capture(in: closure) }
}

extension NSObject: Weakifiable {}
