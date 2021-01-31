//
//  NavigationBarModifier.swift
//  
//
//  Created by Sergey Pugach on 5.01.21.
//

import SwiftUI

struct NavigationBarModifier: ViewModifier {
    
    let tintColor: UIColor?
    let backgroundColor: UIColor?
    
    init(backgroundColor: UIColor? = nil, tintColor: UIColor? = nil) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
//        self.backgroundColor = backgroundColor
//        let coloredAppearance = UINavigationBarAppearance()
//        //coloredAppearance.configureWithTransparentBackground()
//        coloredAppearance.backgroundColor = backgroundColor
//        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//        UINavigationBar.appearance().tintColor = .white
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                self.customiseNavBar(
                    accentColor: self.tintColor,
                    backgroundColor: self.backgroundColor
                )
        }
        .onDisappear {
            self.resetNavBarCustomisation()
        }
//        ZStack{
//            content
//            VStack {
//                GeometryReader { geometry in
//                    Color(self.backgroundColor ?? .clear)
//                        .frame(height: geometry.safeAreaInsets.top)
//                        .edgesIgnoringSafeArea(.top)
//                    Spacer()
//                }
//            }
//        }
    }
    
    private func customiseNavBar(accentColor: UIColor?, backgroundColor: UIColor?) {
        let appearance = UINavigationBarAppearance()
        
        if let backgroundColor = backgroundColor {
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = backgroundColor
            /* todo: CAUTION!
                it changes button's text foreground color only without chevron
                and it's better to change tintColor for all the appearance
            */
            //appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: accentColor]
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        
        if let accentColor = accentColor {
            appearance.titleTextAttributes = [.foregroundColor: accentColor]
            appearance.largeTitleTextAttributes = [.foregroundColor: accentColor]
            /* todo: ATTENTION!
             it sets tint color for even custom buttons and chevrons
             */
            UINavigationBar.appearance().tintColor = accentColor
        }
    }
    
    private func resetNavBarCustomisation() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.titleTextAttributes = [:]
        appearance.largeTitleTextAttributes = [:]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .systemBlue
    }
}

extension View {
 
    func navigationBarBackgroundColor(_ backgroundColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(backgroundColor: backgroundColor))
    }
    
    func navigationBarTintColor(_ tintColor: UIColor?) -> some View {
        self.modifier(NavigationBarModifier(tintColor: tintColor))
    }
}
