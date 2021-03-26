//
//  File.swift
//  
//
//  Created by Sergey Pugach on 7.02.21.
//

import UIKit

public struct Haptic {
    private init(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    private var action: () -> Void
    public func trigger() { action() }
    
    public static func custom<Generator: UIFeedbackGenerator>(
        _ generator: Generator,
        _ action: @escaping (Generator) -> Void
    ) -> Haptic {
        Haptic { action(generator) }
    }
    
    public static var light: Haptic {
        .custom(UIImpactFeedbackGenerator(style: .light)) { $0.impactOccurred() }
    }
    
    public static var medium: Haptic {
        .custom(UIImpactFeedbackGenerator(style: .medium)) { $0.impactOccurred() }
    }
    
    public static var heavy: Haptic {
        .custom(UIImpactFeedbackGenerator(style: .heavy)) { $0.impactOccurred() }
    }
    
    @available(iOS 13.0, *)
    public static var soft: Haptic {
        .custom(UIImpactFeedbackGenerator(style: .soft)) { $0.impactOccurred() }
    }
    
    @available(iOS 13.0, *)
    public static var rigid: Haptic {
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        return Haptic { generator.impactOccurred() }
    }
    
    @available(iOS 13.0, *)
    public static func light(intensity: CGFloat) -> Haptic {
        .custom(UIImpactFeedbackGenerator(style: .light)) { $0.impactOccurred(intensity: intensity) }
    }
    
    @available(iOS 13.0, *)
    public static func medium(intensity: CGFloat) -> Haptic {
        .custom(UIImpactFeedbackGenerator(style: .medium)) { $0.impactOccurred(intensity: intensity) }
    }
    
    @available(iOS 13.0, *)
    public static func heavy(intensity: CGFloat) -> Haptic {
        .custom(UIImpactFeedbackGenerator(style: .heavy)) { $0.impactOccurred(intensity: intensity) }
    }
    
    @available(iOS 13.0, *)
    public static func soft(intensity: CGFloat) -> Haptic {
        .custom(UIImpactFeedbackGenerator(style: .soft)) { $0.impactOccurred(intensity: intensity) }
    }
    
    @available(iOS 13.0, *)
    public static func rigid(intensity: CGFloat) -> Haptic {
        .custom(UIImpactFeedbackGenerator(style: .rigid)) { $0.impactOccurred(intensity: intensity) }
    }
    
    public static var success: Haptic {
        .custom(UINotificationFeedbackGenerator()) { $0.notificationOccurred(.success) }
    }
    
    public static var warning: Haptic {
        .custom(UINotificationFeedbackGenerator()) { $0.notificationOccurred(.success) }
    }
    
    public static var error: Haptic {
        .custom(UINotificationFeedbackGenerator()) { $0.notificationOccurred(.success) }
    }
    
    public static var selection: Haptic {
        .custom(UISelectionFeedbackGenerator()) { $0.selectionChanged() }
    }
}
