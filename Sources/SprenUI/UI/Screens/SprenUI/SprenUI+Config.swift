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
        public let project: SprenProject
        public let color1: Color?
        public let color2: Color?
        
        public var bundle: Bundle = .module
        public var graphics: [Graphic: String] = [
            .greetings: "GreetingsImage",
            .cameraAccessDenied: "CameraAccessDenied",
            .incorrectBodyPosition: "IncorrectBodyPosition",
            .privacy: "Privacy",
            .serverError: "ServerError",
            .setupGuide: "SetupGuide"
        ]
        
        public let onCancel: (() -> Void)
        public let onFinish: ((_ results: Results) -> Void)
        
        // only relevant to demo app
        public let logger: Logger?
        
        // keys for UserDefaults
        public let secondReadingKey = "com.spren.ui.second-reading"
        
        public enum Graphic {
            case greetings
            case cameraAccessDenied
            case incorrectBodyPosition
            case privacy
            case serverError
            case setupGuide
        }
        
        public enum BiologicalSex {
            case male
            case female
            case other
        }
        
        public enum SprenProject {
            case fingerCamera
            case bodyComp
        }
        
        public init(baseURL: String,
                    apiKey: String,
                    userID: String,
                    userGender: BiologicalSex? = nil,
                    userBirthdate: Date? = nil,
                    project: SprenProject,
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
            
            self.project = project
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
