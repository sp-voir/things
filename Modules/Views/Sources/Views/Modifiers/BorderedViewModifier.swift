//
//  BorderedViewModifier.swift
//  
//
//  Created by Sergey Pugach on 5.01.21.
//

import SwiftUI

struct BorderedViewModifier: ViewModifier {
    
    var borderColor: Color
    
    func body(content: Content) -> some View {
        content
            .padding()
            //.padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            //.background(Color.white)
            .overlay(RoundedRectangle(cornerRadius: 8)
                .stroke(lineWidth: 2)
                .foregroundColor(borderColor)
        )
            //.border(Color.blue, width: 2.0)
            .cornerRadius(8)
            //.shadow(color: Color.primary.opacity(0.4), radius: 2, x: 0, y: 0)
    }
}

extension View {
    func bordered(with color: Color = .primary) -> some View {
        ModifiedContent(
            content: self,
            modifier: BorderedViewModifier(borderColor: color)
        )
    }
}
