//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import Foundation

/// Weakly captures an object
///
/// Actually the same as `weak` but initializable
///
/// Usage:
/// ```
/// Weak(object)
/// Weak(self)
/// Weak<FutureObject>(nil)
/// ```
/// or
/// ```
/// protocol SomeClassProtocol: AnyObject {}
///
/// class AnotherClass {
///     @Weak var someClass: SomeClassProtocol?
/// }
/// ```
@dynamicMemberLookup
@propertyWrapper
public struct Weak<Object: AnyObject> {
    public weak var wrappedValue: Object?
    
    public var projectedValue: Object? {
        get { wrappedValue }
        set { wrappedValue = newValue }
    }
    
    public init(_ object: Object?) {
        self.init(wrappedValue: object)
    }
    
    public init() {}
    
    public init(wrappedValue: Object? = nil) {
        self.wrappedValue = wrappedValue
    }
    
    public subscript<T>(dynamicMember keyPath: KeyPath<Object, T>) -> T? {
        wrappedValue?[keyPath: keyPath]
    }
    
    public var isReleased: Bool { wrappedValue == nil }
    public var isRetained: Bool { wrappedValue != nil }
    
    public func ifReleased(execute: @autoclosure () -> (() -> Void)) {
        guard isReleased else { return }
        execute()()
    }
    
    public func ifRetained(execute: @autoclosure () -> ((Object) -> Void)) {
        guard let object = wrappedValue else { return }
        execute()(object)
    }
    
}

extension Weak {
    /// Provides a closure with a weak self as a first parameter for non-returning functions
    ///
    /// Usage:
    /// ```
    /// DispatchQueue.main.async(execute: Weak(object).captured { object in
    ///     object.titleLabel = "Task has been finished"
    /// })
    /// ```
    public func capture(in closure: @escaping (Object) -> Void) -> (() -> Void) {
        return { [weak wrappedValue] in
            guard let object = wrappedValue else { return }
            closure(object)
        }
    }
    
    /// Provides a closure with a weak self as a first parameter for non-returning functions
    ///
    /// Usage:
    /// ```
    /// fetchSomething(completion: Weak(object).captured { object, result in
    ///     object.handleFetch(result)
    /// }
    /// ```
    public func capture<T0>(in closure: @escaping (Object, T0) -> Void) -> ((T0) -> Void) {
        return { [weak wrappedValue] params in
            guard let object = wrappedValue else { return }
            closure(object, params)
        }
    }
    
    public func capture<T0, T1>(in closure: @escaping (Object, T0, T1) -> Void) -> ((T0, T1) -> Void) {
        return { [weak wrappedValue] t0, t1 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1)
        }
    }
    
    public func capture<T0, T1, T2>(in closure: @escaping (Object, T0, T1, T2) -> Void) -> ((T0, T1, T2) -> Void) {
        return { [weak wrappedValue] t0, t1, t2 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1, t2)
        }
    }
    
    public func capture<T0, T1, T2, T3>(in closure: @escaping (Object, T0, T1, T2, T3) -> Void) -> ((T0, T1, T2, T3) -> Void) {
        return { [weak wrappedValue] t0, t1, t2, t3 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1, t2, t3)
        }
    }
    
    public func capture<T0, T1, T2, T3, T4>(in closure: @escaping (Object, T0, T1, T2, T3, T4) -> Void) -> ((T0, T1, T2, T3, T4) -> Void) {
        return { [weak wrappedValue] t0, t1, t2, t3, t4 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1, t2, t3, t4)
        }
    }
    
    public func capture<T0, T1, T2, T3, T4, T5>(in closure: @escaping (Object, T0, T1, T2, T3, T4, T5) -> Void) -> ((T0, T1, T2, T3, T4, T5) -> Void) {
        return { [weak wrappedValue] t0, t1, t2, t3, t4, t5 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1, t2, t3, t4, t5)
        }
    }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6>(in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6) -> Void) -> ((T0, T1, T2, T3, T4, T5, T6) -> Void) {
        return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1, t2, t3, t4, t5, t6)
        }
    }
    
    public func capture<T0, T1, T2, T3, T4, T5, T6, T7>(in closure: @escaping (Object, T0, T1, T2, T3, T4, T5, T6, T7) -> Void) -> ((T0, T1, T2, T3, T4, T5, T6, T7) -> Void) {
        return { [weak wrappedValue] t0, t1, t2, t3, t4, t5, t6, t7 in
            guard let object = wrappedValue else { return }
            closure(object, t0, t1, t2, t3, t4, t5, t6, t7)
        }
    }
}

/*
 class Example: Weakifiable {
     @Weak(nil) var viewController: UIViewController?

     var strongObject: NSObject

     init(_ object: NSObject) {
         strongObject = object
     }

     func someCall() {
         // use $-sign to access actual value
         print($viewController)

         // property wrapper capturing
         asyncCall(_viewController.captured { vc in
             vc.title = "Done"
         })
         
         // weakifying of an object
         asyncCall(Weak(strongObject).captured { object in
             print(object.hash)
         })

         // weakifying of self (recommended)
         asyncCall(captured { _self in
             print(_self)
         })
     }
     
     func asyncCall(_ action: @escaping () -> Void) {
         //...
     }
 }
 */
