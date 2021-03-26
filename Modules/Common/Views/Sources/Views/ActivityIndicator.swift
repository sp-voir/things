//
//  File.swift
//  
//
//  Created by Sergey Pugach on 19.03.21.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    let style: UIActivityIndicatorView.Style
    init(style: UIActivityIndicatorView.Style = .medium) {
        self.style = style
    }
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView()
        view.style = style
        view.startAnimating()
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
    }
}
