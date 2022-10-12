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
        public var userGender: BiologicalSex?
        public var userBirthdate: Date?
        
        // UI config
        public let color1: Color?
        public let color2: Color?
        
        public var bundle: Bundle = .module
        public var graphics: [Graphic: String] = [
            .greeting1: "GreetingScreen1",
            .greeting2: "GreetingScreen2",
            .fingerOnCamera: "FingerOnCamera",
            .noCamera: "NoCamera",
            .serverError: "Server"
        ]
        
        public let onCancel: (() -> Void)
        public let onFinish: ((_ results: Results) -> Void)
        
        // only relevant to demo app
        public let logger: Logger?
        
        // keys for UserDefaults
        public let secondReadingKey = "com.spren.ui.second-reading"
        
        public enum BiologicalSex: String, CaseIterable {
            case male
            case female
            case other
        }
        
        public enum Graphic {
            case greeting1
            case greeting2
            case fingerOnCamera
            case noCamera
            case serverError
        }
        
        public init(baseURL: String,
                    apiKey: String,
                    userID: String,
                    userGender: BiologicalSex? = nil,
                    userBirthdate: Date? = nil,
                    color1: Color? = nil,
                    color2: Color? = nil,
                    graphics: [Graphic: String]? = nil,
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
            if let graphics = graphics {
                self.graphics = graphics
                self.bundle = .main
            }

            self.onCancel = onCancel
            self.onFinish = onFinish
            
            self.logger = logger
        }
    }
}
