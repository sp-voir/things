import Combine
import ComposableArchitecture
import FunctionalClosures

/// This class handles store & environment management
final public class ComposableCore<
    State: Equatable,
    Action: Equatable,
    Environment
> {
    public typealias Store = ComposableArchitecture.Store<State, Action>
    public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>
    public typealias Subscriptions = Set<AnyCancellable>
    
    public var state: State! { viewStore?.state }
    private(set) public var store: Store!
    private(set) public var viewStore: ViewStore!
    private(set) public var environment: Environment!
    private(set) public var subscriptions: Subscriptions = []
    
    /// Handler for state rebinding on the `setStore` method call
    @FunctionalDataSource<StorePublisher<State>, Subscriptions>
    public var bind
    
    /// Handler for the `setStore` method completion
    @FunctionalHandler<ComposableCore>
    public var storeWasSet
    
    /// Handler for `setEnvironment` method completion
    @FunctionalHandler<ComposableCore>
    public var environmentWasSet
    
    /// Sets the store to the viewController
    public func setStore(_ store: Store) {
        self.store = store
        self.viewStore = ViewStore(store)
        
        self.subscribeToStateChanges()
        self.$storeWasSet?(self)
    }
    
    /// Sets environment to the viewController
    public func setEnvironment(_ environment: Environment) {
        self.environment = environment
        self.$environmentWasSet?(self)
    }
    
    /// Resets subscriptions and makes new with `bind` action
    public func subscribeToStateChanges() {
        subscriptions.forEach { $0.cancel() }
        if let publisher = viewStore?.publisher, let bind = $bind {
            subscriptions = bind(publisher)
        } else {
            subscriptions = []
        }
    }
    
    /// Sends and action to the viewStore on the specified queue asyncroniously on a main thread if store was set
    public func send(_ action: Action) {
        viewStore.map { viewStore in
            DispatchQueue.main.async {
                viewStore.send(action)
            }
        }
    }
}
