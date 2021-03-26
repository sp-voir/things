//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import SwiftUI

// MARK: - API
@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension View {
    public func foreground<Overlay: View>(_ overlay: Overlay) -> some View {
        self.overlay(overlay).mask(self)
    }
}
