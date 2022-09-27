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
        public let userGender: Gender?
        public let userBirthdate: Date?
        
        // UI config
        public let color: Color?
        public let onCancel: (() -> Void)
        public let onFinish: ((_ results: Results) -> Void)
        
        // only relevant to demo app
        public let logger: Logger?
        public let homeScreen: Bool
        
        public let secondReadingKey = "com.spren.ui.second-reading"
        
        public enum Gender {
            case male
            case female
        }
        
        public init(baseURL: String,
                    apiKey: String,
                    userID: String,
                    userGender: Gender? = nil,
                    userBirthdate: Date? = nil,
                    color: Color? = nil,
                    onCancel: @escaping (() -> Void),
                    onFinish: @escaping ((Results) -> Void),
                    logger: Logger? = nil,
                    homeScreen: Bool = false) {
            self.baseURL = baseURL
            self.apiKey = apiKey
            
            self.userID = userID
            self.userGender = userGender
            self.userBirthdate = userBirthdate
            
            self.color = color
            self.onCancel = onCancel
            self.onFinish = onFinish
            
            self.logger = logger
            self.homeScreen = homeScreen
        }
    }
}
