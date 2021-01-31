import Combine
import ComposableArchitecture
import SwiftUI

@propertyWrapper
final public class ComposableChildController<Controller: ComposableViewControllerProtocol> {
    public typealias State = Controller.State
    public typealias Action = Controller.Action
    public typealias Environment = Controller.Environment
    public typealias Store = Controller.Store
    
    private(set) public var store: Store?
    private(set) public weak var controller: Controller?
    
    public init() {}
    
    public var wrappedValue: Controller? { controller }
    public var projectedValue: ComposableChildController { self }
    
    /// Sets a new store to the intance and it's controller
    ///
    /// Note: Store is capured strongly, so if controller is `nil`, store will be set to controller as soon as the controller is set.
    public func setStore(_ store: Store) {
        self.store = store
        self.controller?.core.setStore(store)
    }
    
    /// Sets a new controller to the instance and sets current store to the controller if `store != nil`
    ///
    /// Trailing closure enables you to capture or setup controller after it was set if needed.
    ///
    /// Note: the controller is captured weakly, so make sure that you save a strong reference (for example via presenting, pushing or just storing it) at the caller site.
    public func set(
        _ controller: Controller,
        then performAction: (Controller) -> Void = { _ in }
    ) {
        self.controller = controller
        store.map { controller.core.setStore($0) }
        performAction(controller)
    }
}

@propertyWrapper
final public class ComposableChildHostingController<View: ComposableView> {
    public typealias State = View.State
    public typealias Action = View.Action
    public typealias Environment = Void
    public typealias Store = View.Store
    public typealias Controller = UIHostingController<View>
    
    public let core: ComposableCore<State, Action, Environment> = .init()
    private(set) public weak var controller: Controller?
    
    public init() {}
    
    public var wrappedValue: Controller? { controller }
    public var projectedValue: ComposableChildHostingController { self }
    
    /// Sets a new store to the intance and it's controller
    ///
    /// Note: Store is capured strongly, so if controller is `nil`, store will be set to controller as soon as the controller is set.
    public func setStore(_ store: Store) {
        self.core.setStore(store)
        self.controller?.rootView = View(store: store)
    }
    
    /// Sets a new controller to the instance and sets current store to the controller if `store != nil`
    ///
    /// Trailing closure enables you to capture or setup controller after it was set if needed.
    ///
    /// Note: the controller is captured weakly, so make sure that you save a strong reference (for example via presenting, pushing or just storing it) at the caller site.
    public func set(
        _ controller: Controller,
        then performAction: (Controller) -> Void = { _ in }
    ) {
        self.controller = controller
        self.core.store.map {
            controller.rootView = View(store: $0)
        }
        performAction(controller)
    }
    
    public func tryCreateControllerForStoreIfNeeded(then performAction: (Controller) -> Void = { _ in }) {
        guard
            controller == nil,
            let store = core.store
        else { return }
        setStore(store)
        let view = View(store: store)
        let controller = UIHostingController(rootView: view)
        set(controller, then: performAction)
    }
}

@dynamicMemberLookup
open class ComposableViewController<
    State: Equatable,
    Action: Equatable,
    Environment
>: UIViewController, ComposableViewControllerProtocol {
    private var isConfiguredAtLeastOnce = false
    public let core: Core = .init()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        __setupCore()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        __setupCore()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        __setupCore()
    }
    
    private func __setupCore() {
        core.bind { [unowned self] state in
            if !isConfiguredAtLeastOnce { self.configure() }
            var subscriptions = Set<AnyCancellable>()
            self.bind(state, into: &subscriptions)
            return subscriptions
        }
    }
    
    public override func loadView() {
        guard let body = makeContentView() else {
            super.loadView()
            return
        }
        self.view = body
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    open func bind(_ state: StorePublisher<State>, into subscriptions: inout Core.Subscriptions) {}
    open func makeContentView() -> UIView? { nil }
    open func configure() { isConfiguredAtLeastOnce = true }
}

@dynamicMemberLookup
open class ComposableTabBarController<
    State: Equatable,
    Action: Equatable,
    Environment
>: UITabBarController, ComposableViewControllerProtocol {
    public let core: Core = .init()
    
    public init() {
        super.init(nibName: nil, bundle: nil)
        __setupCore()
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        __setupCore()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        __setupCore()
    }
    
    private func __setupCore() {
        core.bind { [unowned self] state in
            var subscriptions = Set<AnyCancellable>()
            self.bind(state, into: &subscriptions)
            return subscriptions
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
    }
    
    open func bind(_ state: StorePublisher<State>, into subscriptions: inout Core.Subscriptions) {}
    open func configure() {}
}
