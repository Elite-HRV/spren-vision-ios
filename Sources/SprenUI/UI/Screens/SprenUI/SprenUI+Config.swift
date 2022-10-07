//
//  SprenUI+Config.swift
//  SprenUI
//
//  Created by Keith Carolus on 8/18/22.
//

import Foundation
import SwiftUI
import Logging

extension SprenUI {
    public struct Config {
        // API config
        public let baseURL: String
        public let apiKey: String
        
        // user config
        public let userID: String
        public let userGender: BiologicalSex?
        public let userBirthdate: Date?
        
        // UI config
        public let color1: Color?
        public let color2: Color?
        public let onCancel: (() -> Void)
        public let onFinish: ((_ results: Results) -> Void)
        
        // only relevant to demo app
        public let logger: Logger?
        public let homeScreen: Bool
        
        // keys for UserDefaults
        public let secondReadingKey = "com.spren.ui.second-reading"
        
        public enum BiologicalSex {
            case male
            case female
            case other
        }
        
        public init(baseURL: String,
                    apiKey: String,
                    userID: String,
                    userGender: BiologicalSex? = nil,
                    userBirthdate: Date? = nil,
                    color1: Color? = nil,
                    color2: Color? = nil,
                    onCancel: @escaping (() -> Void),
                    onFinish: @escaping ((Results) -> Void),
                    logger: Logger? = nil) {
            self.baseURL = baseURL
            self.apiKey = apiKey
            
            self.userID = userID
            self.userGender = userGender
            self.userBirthdate = userBirthdate
            
            self.color1 = color1
            self.color2 = color2

            self.onCancel = onCancel
            self.onFinish = onFinish
            
            self.logger = logger
        }
    }
}
