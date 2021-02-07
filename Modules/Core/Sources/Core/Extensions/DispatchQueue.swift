//
//  DispatchQueue.swift
//  
//
//  Created by Sergey Pugach on 5.01.21.
//

import Dispatch
import Combine

extension DispatchQueue {
    /// Dispatch block asynchronously
    /// - Parameter block: Block

    func publisher<Output, Failure: Error>(_ block: @escaping (Future<Output, Failure>.Promise) -> Void) -> AnyPublisher<Output, Failure> {
        Future<Output, Failure> { promise in
            self.async { block(promise) }
        }.eraseToAnyPublisher()
    }
}
