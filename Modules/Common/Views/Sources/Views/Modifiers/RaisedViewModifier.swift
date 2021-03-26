//
//  RaisedViewModifier.swift
//  
//
//  Created by Sergey Pugach on 5.01.21.
//

import SwiftUI

struct RaisedViewModifier: ViewModifier {
    
    let backgroundColor: Color
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
//            .background(
//                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
//                    .fill(Color("background"))
//                    // Note: The shadow goes on the background, not the button.
//                    .shadow(color: Color("highlight"), radius: 3, x: -4, y: -4)
//                    .shadow(radius: 3, x: 4, y: 4)
//        )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    //.fill(Color("background"))
                    .stroke(backgroundColor, lineWidth: 2)
                    .shadow(radius: 2, x: 2, y: 2)
        )
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color("background"), lineWidth: 2)
                    .shadow(color: Color("highlight"), radius: 2, x: -2, y: -2)
        )
    }
}

extension View {
    func raised(backgroundColor: Color = Color("background"),
                cornerRadius: CGFloat = 8.0) -> some View {
        ModifiedContent(
            content: self,
            modifier: RaisedViewModifier(
                backgroundColor: backgroundColor,
                cornerRadius: cornerRadius
            )
        )
    }
}

struct RaisedViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
        Rectangle()
            .fill(Color.red)
            .cornerRadius(16.0)
        .frame(width: 100, height: 100)
            .raised(backgroundColor: .red, cornerRadius: 16.0)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
