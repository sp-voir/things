//
//  File.swift
//  
//
//  Created by Sergey Pugach on 19.03.21.
//

import SwiftUI

struct VisibilityViewModifier: ViewModifier {
    
    var isVisible: Bool
    
    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            } else {
                content.hidden()
            }
        }
    }
}

extension View {
    
    public func visible(_ isVisible: Bool) -> some View {
        modifier(VisibilityViewModifier(isVisible: isVisible))
    }
    
    public func hidden(_ hidden: Bool) -> some View {
        modifier(VisibilityViewModifier(isVisible: !hidden))
    }
}
