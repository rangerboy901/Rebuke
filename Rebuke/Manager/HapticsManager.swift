//
//  HapticsManager.swift
//  Rebuke
//
//  Created by Joseph William DeWeese on 9/5/22.
//

import SwiftUI


class HapticManager {
    
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}
//Definition
//public enum FeedbackType : Int {
//
//
//    case success = 0
//
//    case warning = 1
//
//    case error = 2
//}
//}
//
//// UINotificationFeedbackGenerator is used to give user feedback when an notification is displayed
//
//@available(iOS 10.0, *)
//open class UINotificationFeedbackGenerator : UIFeedbackGenerator {
//
//
///// call when a notification is displayed, passing the corresponding type
//open func notificationOccurred(_ notificationType: UINotificationFeedbackGenerator.FeedbackType)
//}
