//
//  SignInView.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import SwiftUI
import ComposableArchitectureApp

extension SignIn {
    public struct SignInView: ComposableView {
        
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
                    Spacer()
                }
            }
        }
    }
}

private extension SignIn.SignInView {
    
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
                action: {},
                label: {
                    Text("Sign in")
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignIn.SignInView(
            store: Store<SignIn.State, SignIn.Action>(
                initialState: .initial,
                reducer: SignIn.reducer,
                environment: SignIn.Environment()
            )
        )
    }
}

