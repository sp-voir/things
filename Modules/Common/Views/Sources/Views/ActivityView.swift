//
//  File.swift
//  
//
//  Created by Sergey Pugach on 19.03.21.
//

import SwiftUI

fileprivate enum Constant {
    static let isActiveDefault: Bool = false
    static let blurRadiusDefault: CGFloat = 2.0
}

struct ActivityView<Content: View>: View {
    
    let isActive: Bool
    let blurRadius: CGFloat
    let content: () -> Content
    init(
        isActive: Bool = Constant.isActiveDefault,
        blurRadius: CGFloat = Constant.blurRadiusDefault,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.isActive = isActive
        self.content = content
        self.blurRadius = blurRadius
    }
    
    var body: some View {
        Group {
            if isActive {
                ZStack {
                    content()
                        .blur(radius: blurRadius)
                        //.animation(.easeInOut(duration: 0.25)) //not working
                    ActivityIndicator(style: .large)
                }
            } else {
                content()
            }
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView {
            Text("SomeText here")
        }
    }
}

struct ActivityModifier: ViewModifier {
    
    var isActive: Bool
    var blurRadius: CGFloat
    
    func body(content: Content) -> some View {
        return ActivityView(
        isActive: isActive,
        blurRadius: blurRadius
        ) {
            content
        }
    }
}

extension View {
    func activity(isActive: Bool = Constant.isActiveDefault, blurRadius: CGFloat = Constant.blurRadiusDefault) -> some View {
        ModifiedContent(
            content: self,
            modifier: ActivityModifier(isActive: isActive, blurRadius: blurRadius)
        )
    }
}
