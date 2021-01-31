//
//  Preview.swift
//  
//
//  Created by Sergey Pugach on 4.01.21.
//

import SwiftUI


///Localization and Locale must be update later
struct Preview<Content: View>: View {

    private let dynamicTypeSizes: [ContentSizeCategory] = [
        .extraSmall, .large, .extraExtraExtraLarge
    ]

    /// Filter out "base" to prevent a duplicate preview.
    private let localizations = Bundle.main.localizations
        .map(Locale.init)
        .filter { $0.identifier != "base" }

    private let content: Content
    
    init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        Group {
            self.content
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .previewDisplayName("Default preview")

            self.content
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Dark Mode preview")

            ForEach(localizations, id: \.identifier) { locale in
                self.content
                    .previewLayout(PreviewLayout.sizeThatFits)
                    .padding()
                    .environment(\.locale, locale)
                    .previewDisplayName(Locale.current.localizedString(forIdentifier: locale.identifier))
            }

            ForEach(dynamicTypeSizes, id: \.self) { sizeCategory in
                self.content
                    .previewLayout(PreviewLayout.sizeThatFits)
                    .padding()
                    .environment(\.sizeCategory, sizeCategory)
                    .previewDisplayName("\(sizeCategory)")
            }

        }
    }
}
