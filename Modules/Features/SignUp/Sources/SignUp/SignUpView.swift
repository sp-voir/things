//
//  SignUpView.swift
//  Things
//
//  Created by Sergey Pugach on 18.03.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import SwiftUI
import ComposableArchitectureApp
import Authentication
import Views

extension SignUp {
    public struct SignUpView: ComposableView {
        
        public let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            WithViewStore(store) { (viewStore: ViewStore<State, Action>) in
                VStack(spacing: 0.0) {
                    Text("Things")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    contentBody(for: viewStore)
                    Spacer()
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .red))
                        .visible(viewStore.isLoading)
                    Spacer()
                }
                .disabled(viewStore.isLoading)
                .alert(store.scope(state: \.alertState), dismiss: Action.alertDismissed)
            }
        }
    }
}

private extension SignUp.SignUpView {
    
    func contentBody(for viewStore: ViewStore<State, Action>) -> some View {
        VStack(spacing: 16) {
            TextField(
                "Email",
                text: viewStore.binding(
                    get: { $0.email },
                    send: Action.emailChanged
                )
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            SecureField(
                "Password",
                text: viewStore.binding(
                    get: { $0.password },
                    send: Action.passwordChanged
                )
            )
            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(
                action: {
                    viewStore.send(.signUpTapped)
                },
                label: {
                    Text("Sign up")
                }
            )
            .disabled(!viewStore.isValid)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(viewStore.isValid ? Color.blue : Color.gray, lineWidth: 1.0)
            )
        }
        .padding()
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        Preview {
            SignUp.SignUpView(
                store: Store<SignUp.State, SignUp.Action>(
                    initialState: .initial,
                    reducer: SignUp.reducer,
                    environment: SignUp.Environment(
                        authentication: Authentication.mock
                    )
                )
            )
        }
    }
}

