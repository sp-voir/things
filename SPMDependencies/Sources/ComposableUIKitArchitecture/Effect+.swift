import ComposableArchitecture
import FunctionalClosures
import Combine
import UIKit
import SwiftUI

extension Effect {
    /// Sends syncronious value as an Effect
    public static func value(_ value: Output) -> Effect {
        Effect(value: value)
    }
}
