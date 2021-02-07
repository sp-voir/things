//
//  PaywallV1View.swift
//  
//
//  Created by Sergey Pugach on 26.01.21.
//

import SwiftUI
import ComposableArchitecture
import RemoteConfiguration
import InAppPurchases
import Views
import Core

public struct PaywallV1View: View {
    
    private let store: Store<PaywallV1.State, PaywallV1.Action>
    
    public init(store: Store<PaywallV1.State, PaywallV1.Action>) {
        self.store = store
    }
    
    public var body: some View {
        WithViewStore(self.store) { (viewStore: ViewStore<PaywallV1.State, PaywallV1.Action>) in
        ZStack {
            VStack(alignment: .center, spacing: 0.0) {
                Image("v1_paywall", bundle: .module)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                //.frame(width: geo.size.width, height: geo.size.height - 158)
                Color.clear
                    .frame(width: .infinity, height: 139)
            }
            .edgesIgnoringSafeArea(.all)

            VStack(spacing: 0.0) {
                Color.clear
                Color.clear
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                Gradient.Stop.init(color: .clear, location: 0.0),
                                Gradient.Stop.init(color: .black, location: 0.82),
                                Gradient.Stop.init(color: .black, location: 1.0),
                            ]),
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                    .frame(width: .infinity, height: 250)
            }
            //.opacity(0.5)
            
            
            VStack(spacing: 0.0) {
                HStack {
                    AlphaButton<Text>(
                        label: Text("Restore")
                            .font(.footnote),
                        action: {},
                        configuration: AlphaButton.Configuration(
                            padding: .init(horizontal: 16.0, vertical: 8.0),
                            background: Color(UIColor.white.withAlphaComponent(0.5))
                        )
                    )
                    .frame(width: 86, height: 36, alignment: .center)
                    
                    Color(.clear)
                        .frame(width: .infinity, height: 0.0)
                    
                    AlphaButton<Image>(
                        label: Image(systemName: "xmark"),
                        action: {},
                        configuration: AlphaButton.Configuration(
                            padding: .all(10),
                            background: Color(UIColor.white.withAlphaComponent(0.5))
                        )
                    )
                    .frame(width: 30, height: 30, alignment: .center)
                }
                .padding(.init(horizontal: 10, vertical: 0))
                Spacer()
            }
        }
        .onAppear(perform: {
            viewStore.send(.fetching)
        })
        //.background(Color.clear)
        }
    }
}

struct PaywallV1View_Previews: PreviewProvider {
    static var previews: some View {
        PaywallV1View(
            store: Store(
                initialState: .initial,
                reducer: PaywallV1.reducer,
                environment: PaywallV1.Environment(
                    remoteConfiguration: RemoteConfiguration.mock,
                    purchases: InAppPurchases.mock
                )
            )
        )
            //.previewLayout(.sizeThatFits)
            //.padding()
    }
}
