//
//  ProfileView.swift
//  Things
//
//  Created by Sergey Pugach on 10.02.21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitectureApp

extension Profile {
    public struct ProfileView: ComposableView {
        
        public let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            Text("profile")
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        Profile.ProfileView(
            store: Store<Profile.State, Profile.Action>(
                initialState: .initial,
                reducer: Profile.reducer,
                environment: Profile.Environment()
            )
        )
    }
}

