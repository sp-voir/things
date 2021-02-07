//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import Foundation
import LocalAuthentication

@propertyWrapper
public class Authenticated {
    public typealias Action = () -> Void
    
    private var _action: Action = {}
    private var _onStart: Action?
    private var _onSuccess: Action?
    private var _onFailure: ((LAContext.EvaluationFailure) -> Void)?
    private var _onCompletion: Action?
    
    public func onStart(perform action: Action?) {
        _onStart = action
    }
    
    public func onSuccess(perform action: Action?) {
        _onSuccess = action
    }
    
    public func onFailure(perform action: ((LAContext.EvaluationFailure) -> Void)?) {
        _onFailure = action
    }
    
    public func onCompletion(perform action: Action?) {
        _onCompletion = action
    }
    
    public var reason: String
    public var policy: LAPolicy = .deviceOwnerAuthentication
    
    public var cancelTitle: String?
    public var fallbackTitle: String?
    
    public var wrappedValue: Action {
        get { _action }
        set { updateAction(newValue) }
    }
    
    public init(reason: String) {
        self.reason = reason
        self.wrappedValue = {}
    }
    
    public init(wrappedValue: @escaping Action) {
        self.reason = "Biometrics are used to verify your identity."
        self.wrappedValue = wrappedValue
    }
    
    public init(wrappedValue: @escaping Action, reason: String) {
        self.reason = reason
        self.wrappedValue = wrappedValue
    }
    
    private func tryExecute(action: @escaping Action) {
        DispatchQueue.main.async { self._onStart?() }
        LAContext().tryEvaluatePolicy(policy, reason: reason) { [weak self] result in
            self?.handleEvaluation(result, with: action)
        }
    }
    
    private func handleEvaluation(_ result: LAContext.EvaluationResult, with action: Action) {
        switch result {
        case .success:
            action()
            DispatchQueue.main.async { self._onSuccess?() }
        case .failure(let error):
            DispatchQueue.main.async { self._onFailure?(error) }
        }
        DispatchQueue.main.async { self._onCompletion?() }
    }
    
    private func updateAction(_ action: @escaping Action) {
        _action = { [weak self] in self?.tryExecute(action: action) }
    }
    
}

/*
 @Authenticated(reason: "Identify yourself")
 private var signIn: () -> Void

 //...
 func setupAuthentication() {
     // here you can change policy if needed
     // _signIn.policy = .deviceOwnerAuthentication // default

     // setup handlers
     // called just before the start of authentication
     _signIn.onStart = { [weak self] in
         self?.logger?.trace("User had started sign in process")
     }

     // called after protected action
     _signIn.onSuccess = { [weak self] in
         self?.logger?.error(error)
     }

     // called if authentication was failed somehow
     _signIn.onFailure = { [weak self] error in
         self?.logger?.error(error)
     }

     // called after any completion (success or failure)
     _signIn.onCompletion = { [weak self] error in
         self?.logger?.trace("User sign in process ended")
     }

     // set protected action

     // called only after system authentication success
     signIn = { [weak self] in
         print("Authenticated action")
     }
 }

 // call protected action
 @IBOutlet signInButtonTap() { signIn() }
 */
