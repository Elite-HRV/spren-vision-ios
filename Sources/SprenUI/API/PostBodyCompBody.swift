//
//  PostBodyCompBody.swift
//  SprenInternal
//
//  Created by Keith Carolus on 7/14/22.
//

import Foundation

struct BodyCompData: Encodable {
    let timeInfo: TimeInfo
    let gender: String
    let age: Int
    let height: Double
    let weight: Double
    let vigorousDays: Int
    let pushUps: Int
    let image: String
}

struct PostBodyCompBody: Encodable {
    let user: String
    let bodyCompData: BodyCompData
}
