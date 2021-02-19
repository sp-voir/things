//
//  AppView.swift
//  VoirCam
//
//  Created by Sergey Pugach on 12/9/20.
//

import SwiftUI
//import InAppPurchases
//import Paywall
//import RemoteConfiguration
import ComposableArchitectureApp
import Firebase
import Root

@main
struct VoirCam: App {
    
    init() {
        
        //Or better configure in another place/module
        FirebaseConfiguration.shared.setLoggerLevel(.debug)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Root.RootView(
                store: Store<Root.State, Root.Action>(
                    initialState: Root.State(profile: .initial),
                    reducer: Root.reducer,
                    environment: Root.Environment()
                )
            )
        }
    }
}
