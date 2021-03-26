//
//  AppView.swift
//  Things
//
//  Created by Sergey Pugach on 12/9/20.
//

import SwiftUI
import ComposableArchitectureApp
import Firebase
import Root
import Welcome
import Authentication

@main
struct Things: App {
    
    private let authentication: Authenticatable
    @State var isLogged = false
    
    init() {
        
        //Or better configure in another place/module
        FirebaseConfiguration.shared.setLoggerLevel(.debug)
        FirebaseApp.configure()
        
        authentication = Authentication.live //Authentication()
    }
    
    @ViewBuilder
    var body: some Scene {
        WindowGroup {
            if isLogged {
                root
            } else {
                welcome
            }
        }
    }
    
    private var root: some View {
        Root.RootView(
            store: Store<Root.State, Root.Action>(
                initialState: Root.State(profile: .initial),
                reducer: Root.reducer,
                environment: Root.Environment()
            )
        )
    }
    
    private var welcome: some View {
        Welcome.WelcomeView(
            store: ComposableArchitecture.Store<Welcome.State, Welcome.Action>(
                initialState: .initial,
                reducer: Welcome.reducer,
                environment: Welcome.Environment(
                    authentication: authentication
                )
            )
        )
    }
}
