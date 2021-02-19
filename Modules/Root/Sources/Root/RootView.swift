//
//  File.swift
//  
//
//  Created by Sergey Pugach on 8.02.21.
//

import SwiftUI
import ComposableArchitectureApp
import Profile

extension Root {
    public struct RootView: ComposableView {
        
        public let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            TabView {
                Text("someTextHere1")
                    .tabItem {
                        Image(systemName: "list.dash")
                        Text("Menu")
                    }
                profile
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }
            }
        }
        
        private var profile: some View {
            return Profile.ProfileView(
                store: store.scope(
                    state: \.profile,
                    action: Action.profile
                )
            )
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Root.RootView(
            store: Store<Root.State, Root.Action>(
                initialState: Root.State(
                    profile: .initial
                ),
                reducer: Root.reducer,
                environment: Root.Environment()
            )
        )
    }
}
