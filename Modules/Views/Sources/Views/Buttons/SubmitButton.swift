//
//  SubmitButton.swift
//  
//
//  Created by Sergey Pugach on 4.01.21.
//

import SwiftUI
import Resources

public struct SubmitButton: View {
    
    //private let title: String
    public typealias Action = () -> Void
    
    private let title: String
    private let action: Action
    
    public init(title: String, action: @escaping Action) {
        self.title = title
        self.action = action
    }
    
    public var body: some View {
        Button(
            title,
            action: action
        )
        //.foregroundColor(.white)
        //.background(Color("DeepPink", bundle: .module))
        //.background(Color("DeepPink", bundle: Bundle.resources))
        //7
        .background(Color.deepPink)
    }
}

extension SubmitButton {
    
    struct Configuration {
        let padding: EdgeInsets
        let background: Color
    }
}

struct SubmitButton_Previews: PreviewProvider {
    static var previews: some View {
        Preview {
            SubmitButton(
                title: "Preview",
                action: {}
            )
            .previewLayout(.sizeThatFits)
            .padding()
        }
    }
}

