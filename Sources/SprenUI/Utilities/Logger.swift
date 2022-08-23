//
//  Logger.swift
//  Spren
//
//  Created by nick on 24.11.2021.
//

import Foundation

struct Logger {

    internal init(label: String, level: Level = Level.error) {
        
    }

    func trace(_ message: String) {
        print(message)
    }

    func debug(_ message: String) {
        print(message)
    }

    func info(_ message: String) {
        print(message)
    }

    func notice(_ message: String) {
        print(message)
    }

    func warning(_ message: String) {
        print(message)
    }

    func error(_ message: String) {
        print(message)
    }

    func critical(_ message: String) {
        print(message)
    }
}

enum Level {
    case trace
    case debug
    case info
    case notice
    case warning
    case error
    case critical
}
