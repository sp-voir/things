//
//  UIColor+Ext.swift
//  
//
//  Created by Sergey Pugach on 4.01.21.
//

#if os(iOS)
import UIKit

//Please, use `myModule` instead of `module` to access from another packages
public extension UIColor {
    static let deepPink = UIColor(named: "DeepPink", in: .myModule, compatibleWith: nil)!
    static let deepPink2 = UIColor(red: 242, green: 13, blue: 0, alpha: 1.0)
}

extension UIColor {

    convenience init(rgb: UInt, alpha: CGFloat = 1.0) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(alpha)
        )
    }
}
#endif
