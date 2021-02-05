//
//  AppView.swift
//  VoirCam
//
//  Created by Sergey Pugach on 12/9/20.
//

import SwiftUI
import InAppPurchases
import Paywall
import RemoteConfiguration
import ComposableArchitecture
import Firebase

@main
struct AppView: App {
    
    init() {
        FirebaseConfiguration.shared.setLoggerLevel(.debug)
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            PaywallV1View(
                store: Store<PaywallV1.State, PaywallV1.Action>(
                    initialState: PaywallV1.State.initial,
                    reducer: PaywallV1.reducer,
                    environment: PaywallV1.Environment(
                        remoteConfiguration: RemoteConfiguration(),
                        purchases: InAppPurchases()
                    )
                )
            )
//            VStack {
//                Text("title")
//                SubmitButton(title: "Text", action: {})
//            }
        }
    }
}
