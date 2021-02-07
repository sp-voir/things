//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import SwiftUI
import AuthenticationServices

public struct AppleIDButton: View {
    
    public typealias ButtonType = ASAuthorizationAppleIDButton.ButtonType
    public typealias Style = ASAuthorizationAppleIDButton.Style
    
    public var type: ButtonType = .default
    public var style: () -> Style = Style.userInterface
    public var onCompletion: ASCompletionAction
    
    public var body: some View {
        _AppleIDButton(type: type, style: style, onCompletion: onCompletion)
    }
    
}

// MARK: - Implementation details
// MARK: Helpers

public typealias ASCompletionAction = (Result<ASAuthorizationAppleIDCredential, Error>) -> Void

extension ASAuthorizationAppleIDButton.Style {
    
    public static func userInterfaceOutline() -> Self {
        UITraitCollection
            .current.userInterfaceStyle == .dark ?
                .white : .whiteOutline
    }
    
    public static func userInterface() -> Self {
        UITraitCollection
            .current.userInterfaceStyle == .dark ?
                .white : .black
    }
    
}

// MARK: Base implementation

// Tracks user interface style and reloads button
public class AppleIDButtonController: UIViewController {
    
    private let authManager: AuthManager = .init()
    
    public var buttonType: ASAuthorizationAppleIDButton.ButtonType = .default
    public var buttonStyle = ASAuthorizationAppleIDButton.Style.userInterface
    public var onCompletion: ASCompletionAction = { _ in } {
        didSet { authManager.authHandler = onCompletion }
    }
    
    public var button: ASAuthorizationAppleIDButton! {
        view as? ASAuthorizationAppleIDButton
    }
    
    override public func loadView() { reloadButton() }
    
    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        reloadButton()
    }

    public func reloadButton() {
        let button = ASAuthorizationAppleIDButton(type: buttonType, style: buttonStyle())
        button.addTarget(authManager,
                         action: #selector(AuthManager.performRequest),
                         for: .touchUpInside)
        self.view = button
    }
    
}

extension AppleIDButtonController {
    
    private class AuthManager: NSObject, ASAuthorizationControllerDelegate {
        var authHandler: ASCompletionAction?
        @objc func performRequest() {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        }

        func authorizationController(controller: ASAuthorizationController,
                                     didCompleteWithAuthorization authorization: ASAuthorization) {
            guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential
            else { return authHandler?(.failure(
                CastError(ASAuthorizationCredential.self, to: ASAuthorizationAppleIDCredential.self))) ?? ()
            }
            authHandler?(.success(appleIDCredential))
        }

        func authorizationController(controller: ASAuthorizationController,
                                     didCompleteWithError error: Error) {
            authHandler?(.failure(error))
        }
    }
    
}

// MARK: SwiftUI Wrapper for base implementation
private struct _AppleIDButton: UIViewControllerRepresentable {
    
    var type: ASAuthorizationAppleIDButton.ButtonType
    var style: () -> ASAuthorizationAppleIDButton.Style
    var onCompletion: ASCompletionAction
    
    func makeUIViewController(context: Context) -> AppleIDButtonController {
        let controller = AppleIDButtonController()
        controller.buttonType = type
        controller.buttonStyle = style
        controller.onCompletion = onCompletion
        controller.reloadButton()
        return controller
    }
    
    func updateUIViewController(_ uiViewController: AppleIDButtonController, context: Context) { }
    
}

internal struct CastError<T1, T2>: Error {
    
    let type1: T1.Type
    let type2: T2.Type
    
    init(_ type1: T1.Type, to type2: T2.Type) {
        self.type1 = type1
        self.type2 = type2
    }
    
    var localizedDescription: String {
        "Could not cast \(type1) to \(type2)"
    }
    
}
