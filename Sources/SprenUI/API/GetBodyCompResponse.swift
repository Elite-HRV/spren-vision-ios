//
//  GetBodyCompResponse.swift
//  SprenInternal
//
//  Created by Keith Carolus on 7/14/22.
//

import Foundation

protocol CompletableErrorable {
    func isComplete() -> Bool
    func hasError() -> Bool
    func isHumanNotDetectedError() -> Bool
}

struct GetBodyCompResponse: Decodable, CompletableErrorable {

    static let ERROR_HUMAN_NOT_DETECTED_STRING = "Human not detected"

    let bodyFat: StatusValue
    let leanMass: StatusValue
    let fatMass: StatusValue
    let androidFat: StatusValue
    let gynoidFat: StatusValue
    let androidByGynoid: StatusValue
    // let metabolicRate: StatusValue

    init(bodyFat: StatusValue, leanMass: StatusValue, fatMass: StatusValue, androidFat: StatusValue, gynoidFat: StatusValue, androidByGynoid: StatusValue) {
        self.bodyFat = bodyFat
        self.leanMass = leanMass
        self.fatMass = fatMass
        self.androidFat = androidFat
        self.gynoidFat = gynoidFat
        self.androidByGynoid = androidByGynoid
    }

    func isComplete() -> Bool {
        return bodyFat.status == .complete &&
               leanMass.status == .complete &&
               fatMass.status == .complete &&
               androidFat.status == .complete &&
               gynoidFat.status == .complete &&
               androidByGynoid.status == .complete
               // metabolicRate.status == .complete &&
    }

    func hasError() -> Bool {
        let hasError = bodyFat.status == .error ||
            leanMass.status == .error ||
            fatMass.status == .error ||
            androidFat.status == .error ||
            gynoidFat.status == .error ||
            androidByGynoid.status == .error
            // metabolicRate.status == .error ||

        return hasError
    }

    func isHumanNotDetectedError() -> Bool {
        let isHumanNotDetected = bodyFat.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING ||
            leanMass.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING ||
            fatMass.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING ||
            androidFat.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING ||
            gynoidFat.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING ||
            androidByGynoid.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING
            // metabolicRate.errorDescription == GetBodyCompResponse.ERROR_HUMAN_NOT_DETECTED_STRING ||

        return isHumanNotDetected
    }
}
