//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

//import Foundation
//
//extension Bundle {
//    var id: String { bundleIdentifier ?? "" }
//}
//
//@propertyWrapper
//public class Scheduled {
//    private static let defaultQueue = DispatchQueue(
//        label: Bundle.main.id.appending(".queues.scheduled"),
//        qos: .utility,
//        autoreleaseFrequency: .workItem
//    )
//
//    private let lock = NSLock()
//    private(set) var isSuspended = false
//
//    public let interval: TimeInterval
//    public let delay: TimeInterval
//    public let queue: DispatchQueue
//    public var action: () -> Void
//
//    public init(
//        interval: TimeInterval,
//        delay: TimeInterval = 0,
//        action wrappedValue: @escaping () -> Void = {})
//    {
//        self.interval = interval
//        self.delay = delay
//        self.queue = Scheduled.defaultQueue
//        self.action = wrappedValue
//    }
//
//    public init(
//        interval: TimeInterval,
//        delay: TimeInterval = 0,
//        queue: DispatchQueue,
//        action wrappedValue: @escaping () -> Void = {})
//    {
//        self.interval = interval
//        self.delay = delay
//        self.queue = queue
//        self.action = wrappedValue
//    }
//
//    public var wrappedValue: () -> Void {
//        get { action }
//        set {
//            action = newValue
//            resume()
//        }
//    }
//
//    public func suspend() {
//        lock.
//        lock.store(true, in: &isSuspended)
//    }
//
//    public func resume() {
//        lock.store(false, in: &isSuspended)
//        queue.asyncAfter(deadline: .now() + delay) {
//            self.runLoop()
//        }
//    }
//
//    private func runLoop(_ active: Bool = true) {
//        guard active else { return }
//        action()
//
//        let shouldStopExecution = isSuspended
//        queue.asyncAfter(deadline: .now() + interval) { [weak self] in
//            self?.runLoop(!shouldStopExecution)
//        }
//    }
//
//}

/*
 class CounterViewController: UIViewController {
     @Scheduled(interval: 1)
     private var updateLabel: () -> Void

     private var count: Int = 0

     override func loadView() { self.view = UILabel() }

     override func viewDidLoad() {
         super.viewDIdLoad()
         updateLabel = { [weak self]
             self?.count += 1
             self?.label.text = String(self?.count ?? 0)
         } // starts automatically
     }
 }
 Also you can use

 _updateLabel.suspend() // pauses execution
 _updateLabel.resume() // continues execution
 _updateLabel.isSuspended
 */
