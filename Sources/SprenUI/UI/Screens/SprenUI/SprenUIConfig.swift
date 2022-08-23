//
//  SprenConfig.swift
//  SprenInternal
//
//  Created by Keith Carolus on 8/18/22.
//

import Foundation

extension SprenUI {
    public struct Config {
        public let baseURL: String
        public let apiKey: String
        public let userID: String
        
        public init(baseURL: String, apiKey: String, userID: String) {
            self.baseURL = baseURL
            self.apiKey = apiKey
            self.userID = userID
        }
    }
}
