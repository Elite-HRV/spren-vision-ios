//
//  AnalyzingScreen+API.swift
//  SprenInternal
//
//  Created by nick on 05.08.2022.
//

import SwiftUI
//import Sentry

extension AnalyzingScreen {
    func upload(image: UIImage) {
        guard let imageBase64Encoded = image.jpegData(compressionQuality: 0.5)?
                .base64EncodedString(options: .lineLength64Characters) else {
//            SentrySDK.capture(message: "AnalyzingScreen failed to base64 encode body comp image")
            return
        }

        let weight = UserData.getUserWeight()
        let height = UserData.getUserHeight()
        let biologicalSex = UserData.getBiologicalSex()
        let age = UserData.getAge()
        let vigorousDays = UserData.getFitnessLevel()

        let body = PostBodyCompBody(
            user: Config.deviceIdentifier,
            bodyCompData: BodyCompData(
                timeInfo: TimeInfo(),
                gender: biologicalSex == 1 ? "female" : "male",
                age: age,
                height: height, // cm
                weight: weight, // kg
                vigorousDays: vigorousDays,
//                pushUps: 0,
                image: imageBase64Encoded
            )
        )
        self.asyncAPIService.post(body: body)
    }
}
