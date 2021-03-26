//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import SwiftUI

struct _ViewModifier<Input: View, Output: View>: ViewModifier {
    typealias Body = Output
    typealias Content = _ViewModifier_Content<_ViewModifier<Input, Output>>
    
    var modification: (Content) -> Output
    func body(content: Content) -> Output {
        modification(content)
    }
    
}

extension View {
    func modifier<T: View>(_ viewModifier: _ViewModifier<Self, T>)
    -> ModifiedContent<Self, _ViewModifier<Self, T>> {
        _modifier(viewModifier)
    }
    
    private func _modifier<T: ViewModifier>(_ viewModifier: T)
    -> ModifiedContent<Self, T> {
        modifier(viewModifier)
    }
}

extension View {
    func eraseToAnyView() -> AnyView { .init(self) }
}

/*
 extension _ViewModifier {

     // Declaration
     static func largeButton<T: View>() -> _ViewModifier<T, AnyView> {
         let size = CGSize(width: 300, height: 50)
         let fontModifier: CGFloat = 0.4
         return .init { content in
             content
                 .font(.system(size: round(size.height * fontModifier), weight: .medium))
                 .frame(
                     idealWidth: size.width,
                     maxWidth: .infinity,
                     idealHeight: size.height,
                     maxHeight: size.height
                 )
                 .eraseToAnyView()
         }
     }
     
 }

 // Usage
 Button(action: someAction}) { Text("TapMe") }
     .modifier(.largeButton())
 */
