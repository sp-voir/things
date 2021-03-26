//
//  WelcomeView.swift
//  Things
//
//  Created by Sergey Pugach on 21.02.21.
//  Copyright (c) 2021 Sergey Pugach. All rights reserved.
//

import SwiftUI
import ComposableArchitectureApp
import SignIn
import SignUp
import Authentication

extension Welcome {
    public struct WelcomeView: ComposableView {
        
        public let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            WithViewStore(store) { (viewStore: ViewStore<State, Action>) in
                NavigationView {
                    contentBody(for: viewStore)
                }
            }
        }
    }
}

private extension Welcome.WelcomeView {
    
    func contentBody(for viewStore: ViewStore<State, Action>) -> some View {
        VStack(spacing: 16.0) {
            Text("Things")
                .font(.largeTitle)
                .bold()
            signIn(for: viewStore)
            signUp(for: viewStore)
        }
    }
    
    func signIn(for viewStore: ViewStore<State, Action>) -> some View {
        return NavigationLink.init(
            destination: SignIn.SignInView(
                store: store.scope(
                    state: { $0.signIn },
                    action: Action.signIn
                )
            ),
            label: {
                Text("Sign in")
            })
    }
    
    func signUp(for viewStore: ViewStore<State, Action>) -> some View {
        return NavigationLink.init(
            destination: SignUp.SignUpView(
                store: store.scope(
                    state: { $0.signUp },
                    action: Action.signUp
                )
            ),
            label: {
                Text("Sign up")
            })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        Welcome.WelcomeView(
            store: Store<Welcome.State, Welcome.Action>(
                initialState: .initial,
                reducer: Welcome.reducer.debug(),
                environment: Welcome.Environment(
                    authentication: Authentication.mock
                )
            )
        )
    }
}

