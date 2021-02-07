//
//  AlphaButton.swift
//  
//
//  Created by Sergey Pugach on 31.12.20.
//

import SwiftUI
import Core

public struct AlphaButton<Label>: View where Label: View {
    
    //private typealias ButtonLabel = Label<Text?, Image?>
    public typealias Action = () -> Void
    
    //private let label: ButtonLabel
    private let label: Label
    private let action: Action
    private let configuration: Configuration
    
    public init(
        label: Label,
        action: @escaping Action,
        configuration: Configuration
    ) {
        self.label = label
        self.action = action
        self.configuration = configuration
    }
    
    public var body: some View {
        Button(
            action: action,
            label: {
                label
                    .foregroundColor(.black)
                    .padding(configuration.padding)
                    .background(configuration.background)
                    .clipShape(Capsule())
            }
        )
    }
}

public extension AlphaButton {
    
    struct Configuration {
        let padding: EdgeInsets
        let background: Color
        
        public init(padding: EdgeInsets, background: Color) {
            self.padding = padding
            self.background = background
        }
    }
}

struct AlphaButton_Previews: PreviewProvider {
    static var previews: some View {
        Preview {
            VStack {
                AlphaButton(
                    label: Text("Restore"),
                    action: {},
                    configuration: AlphaButton.Configuration(
                        padding: .init(horizontal: 16.0, vertical: 8.0),
                        background: Color.green
                    )
                )
                .previewLayout(
                    .fixed(
                        width: 86.0,
                        height: 36.0
                    )
                )
                AlphaButton(
                    label: Image(systemName: "xmark"),
                    action: {},
                    configuration: AlphaButton.Configuration(
                        padding: .all(10),
                        background: Color.red
                    )
                )
                .previewLayout(
                    .fixed(
                        width: 30.0,
                        height: 30.0
                    )
                )
            }
        }
    }
}
