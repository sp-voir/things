//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import LocalAuthentication

extension LAContext {
    typealias EvaluationResult = Result<Void, EvaluationFailure>
    
    public enum EvaluationFailure: Error {
        case wrapped(LAError)
        case unknown
        init(_ error: Error?) {
            if let error = error as? LAError { self = .wrapped(error) }
            else { self = .unknown }
        }
    }
    
    /// Authentication request
    ///
    /// See
    /// ```
    /// LAContext.evaluatePolicy
    /// ```
    /// for more info
    func tryEvaluatePolicy(
        _ policy: LAPolicy,
        reason: String,
        reply: @escaping (EvaluationResult) -> Void
    ) {
        var error: NSError?
        if canEvaluatePolicy(policy, error: &error) {
            evaluatePolicy(policy, localizedReason: reason) { result, error in
                guard error == nil else {
                    reply(.failure(EvaluationFailure(error)))
                    return
                }
                reply(result
                    ? .success(())
                    : .failure(EvaluationFailure(error))
                )
            }
        } else if let error = error {
            reply(.failure(EvaluationFailure(error)))
        } else {
            reply(.failure(EvaluationFailure(error)))
        }
    }
    
    func getBiometryType(for policy: LAPolicy = .deviceOwnerAuthentication) -> LABiometryType? {
        var error: NSError?
        if canEvaluatePolicy(policy, error: &error) {
            return biometryType
        } else {
            return nil
        }
    }
}

extension LABiometryType {
    var isSupported: Bool {
        if #available(iOS 11.2, *) { return self != .none }
        else { return [.faceID, .touchID].contains(self) }
    }
}
