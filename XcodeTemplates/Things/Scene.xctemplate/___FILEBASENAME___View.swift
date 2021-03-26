//
//  ___FILENAME___
//  ___PROJECTNAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright (c) ___YEAR___ ___ORGANIZATIONNAME___. All rights reserved.
//

import SwiftUI
import ComposableArchitectureApp

extension ___VARIABLE_feature:identifier___ {
    public struct ___VARIABLE_feature:identifier___View: ComposableView {
        
        public let store: Store<State, Action>
        
        public init(store: Store<State, Action>) {
            self.store = store
        }
        
        public var body: some View {
            WithViewStore(store) { (viewStore: ViewStore<State, Action>) in
                EmptyView()
            }
        }
    }
}

struct ___VARIABLE_feature:identifier____Previews: PreviewProvider {
    static var previews: some View {
        ___VARIABLE_feature:identifier___.___VARIABLE_feature:identifier___View(
            store: Store<___VARIABLE_feature:identifier___.State, ___VARIABLE_feature:identifier___.Action>(
        initialState: .initial,
                reducer: ___VARIABLE_feature:identifier___.reducer,
                environment: ___VARIABLE_feature:identifier___.Environment()
            )
        )
    }
}

