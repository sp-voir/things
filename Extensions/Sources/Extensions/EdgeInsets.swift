//
//  EdgeInsets.swift
//  
//
//  Created by Sergey Pugach on 4.01.21.
//

import SwiftUI

public extension EdgeInsets {
    
    static func all(_ value: CGFloat) -> EdgeInsets {
        .init(horizontal: value, vertical: value)
    }

    init(horizontal hValue: CGFloat = 0.0, vertical vValue: CGFloat = 0.0) {
        self.init(top: vValue, leading: hValue, bottom: vValue, trailing: hValue)
    }
}
