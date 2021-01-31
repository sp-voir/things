import ComposableArchitecture
import SwiftUI

public protocol ComposableView: View {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    typealias Store = ComposableArchitecture.Store<State, Action>
    
    var store: Store { get }
    init(store: Store)
}

/// Protocol that enables you to use composable core and provides convenient typealiases for it
public protocol ComposableCoreProvider {
    associatedtype State: Equatable
    associatedtype Action: Equatable
    associatedtype Environment
    
    var core: ComposableCore<State, Action, Environment> { get }
}

extension ComposableCoreProvider {
    public typealias Core = ComposableCore<State, Action, Environment>
    public typealias Store = Core.Store
    public typealias ViewStore = Core.ViewStore
}

/// This protocol defines ComposableCore support for UIViewControllers and autosupport of
public protocol ComposableViewControllerProtocol: UIViewController, ComposableCoreProvider {}

extension ComposableViewControllerProtocol {
    public subscript<Value>(dynamicMember keyPath: KeyPath<Core, Value>) -> Value {
        return core[keyPath: keyPath]
    }
}
