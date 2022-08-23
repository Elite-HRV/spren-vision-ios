//
//  Haptics.swift
//  SprenInternal
//
//  Created by nick on 03.02.2022.
//

import SwiftUI

class Haptics {

    // soft impacts occurs when:
    // - the conditions checks are met
    // - reading starts (every time including when it restarts)
    static func softImpact() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred()
    }

    // success notification occurs when:
    // - measurement completes
    // - checkmark fills in
    static func successNotification() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
}
