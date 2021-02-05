//
//  Color.swift
//  
//
//  Created by Sergey Pugach on 4.01.21.
//

import SwiftUI

extension Color {

//    var uiColor: UIColor {
//
//        let components = self.components()
//        return UIColor(red: components.r, green: components.g, blue: components.b, alpha: components.a)
//    }

    private func components() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {

        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0

        let result = scanner.scanHexInt64(&hexNumber)
        if result {
            r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
            g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
            b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
            a = CGFloat(hexNumber & 0x000000ff) / 255
        }
        return (r, g, b, a)
    }
}

extension Color {
    
    func uiColor() -> UIColor {
        let hex = self.description
        let space = CharacterSet(charactersIn: " ")
        let trim = hex.trimmingCharacters(in: space)
        let value = hex.first != "#" ? "#\(trim)" : trim
        let values = Array(value)

        func radixValue(_ index: Int) -> CGFloat? {
            var result: CGFloat?
            if values.count > index + 1 {
                var input = "\(values[index])\(values[index + 1])"
                if values[index] == "0" {
                    input = "\(values[index + 1])"
                }
                if let val = Int(input, radix: 16) {
                    result = CGFloat(val)
                }
            }
            return result
        }
        
        var rgb = (red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0), alpha: CGFloat(0))
        if let outputR = radixValue(1) { rgb.red = outputR / 255 }
        if let outputG = radixValue(3) { rgb.green = outputG / 255 }
        if let outputB = radixValue(5) { rgb.blue = outputB / 255 }
        if let outputA = radixValue(7) { rgb.alpha = outputA / 255 }
        return UIColor(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: rgb.alpha)
    }
}
