//
//  View.swift
//  
//
//  Created by Sergey Pugach on 5.01.21.
//

import SwiftUI

extension View {
    func endEditing(_ force: Bool) {
        UIApplication.shared.windows.forEach { $0.endEditing(force)}
    }
}
