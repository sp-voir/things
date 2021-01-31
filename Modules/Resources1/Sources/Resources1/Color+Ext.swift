//
//  Color+Ext.swift
//  
//
//  Created by Sergey Pugach on 4.01.21.
//

import SwiftUI

public extension Color {
    static let deepPink = Color(.deepPink)
}

struct Test: View {
    var body: some View {
        Text("1234543534")
            .padding()
            .background(Color.deepPink)
    }
}



struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
