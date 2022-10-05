//
//  DeviceIdentifier.swift
//  Spren
//
//  Created by nick on 06.01.2022.
//

import Foundation

/// Key to reference instance identifier
private let deviceIdentifierKey = "com.spren.sdk.device-identifier"

struct DeviceIdentifier {
    static let identifier = getUUID()
    static let bundleId = getBundleId()

    /// Instance identifier, persisted to defaults
    static func getUUID() -> String {
        guard let identifier = UserDefaults.standard.string(forKey: deviceIdentifierKey) else {
            let newIdentifier = UUID().uuidString
            UserDefaults.standard.set(newIdentifier, forKey: deviceIdentifierKey)
            return newIdentifier
        }
        return identifier
    }

    static func getBundleId() -> String {
        guard let info = Bundle.main.infoDictionary else { return "Unknown" }
        let bundle = info[kCFBundleIdentifierKey as String] as? String ?? "Unknown"

        return bundle
    }
}
