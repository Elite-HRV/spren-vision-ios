//
//  SprenUI+Config.swift
//  SprenUI
//
//  Created by Keith Carolus on 8/18/22.
//

import Foundation
import Logging

extension SprenUI {
    public struct Config {
        public let baseURL: String
        public let apiKey: String
        public let userID: String
        public let onCancel: (() -> Void)
        public let onFinish: ((_ guid: String, _ hr: Double, _ hrvScore: Double) -> Void)
        public let logger: Logger?
        public let homeScreen: Bool
        
        public let secondReadingKey = "com.spren.ui.second-reading"
        
        public init(baseURL: String, apiKey: String, userID: String, onCancel: @escaping (() -> Void), onFinish: @escaping ((String, Double, Double) -> Void), logger: Logger? = nil, homeScreen: Bool = false) {
            self.baseURL = baseURL
            self.apiKey = apiKey
            self.userID = userID
            self.onCancel = onCancel
            self.onFinish = onFinish
            self.logger = logger
            self.homeScreen = homeScreen
        }
    }
}
