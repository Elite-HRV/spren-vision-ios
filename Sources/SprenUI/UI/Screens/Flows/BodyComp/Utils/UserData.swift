//
//  UserData.swift
//  SprenInternal
//
//  Created by nick on 09.08.2022.
//

import Foundation

private let userWeightKey = "com.spren.bodycomp.key.userWeightV2"
private let userHeightKey = "com.spren.bodycomp.key.userHeightV2"
private let userAgeKey = "com.spren.bodycomp.key.userAge"
private let userBiologicalSexKey = "com.spren.bodycomp.key.biologicalSex"
private let userFitnessLevelKey = "com.spren.bodycomp.key.fitnessLevel"

class UserData: NSObject {

    var weight: Double
    // 0 => lbs, 1 => kg
    var weightMetric: Int
    static let weightMetricLables = ["lbs", "kg"]

    var height: HeightSize

    var age: Int

    // 0 => male, 1 => female, 2 => other
    var biologicalSex: Int
    var fitnessLevel: Int

    static let DEFAULT_WEIGHT: Double = 155.0
    static let DEFAULT_WEIGHT_METRIC: Int = 0

    static let DEFAULT_HEIGHT_FEET: Int = 5
    static let DEFAULT_HEIGHT_INCHES: Int = 9
    // 0 => ft_in, 1 => cm
    static let DEFAULT_HEIGHT_METRIC: Int = 0
    static let DEFAULT_HEIGHT_CENTIMETERS: Int = 175

    static let DEFAULT_AGE = 38

    static let `default`: UserData = {
        return UserData()
    }()

    override init() {
        let weightParams = UserData.getWeight()
        self.weight = weightParams.0
        self.weightMetric = weightParams.1
        self.height = UserData.getHeight()
        self.age = UserData.getAge()
        self.biologicalSex = UserData.getBiologicalSex()
        self.fitnessLevel = UserData.getFitnessLevel()
    }

    func saveWeight(_ weight: Double, _ weightMetric: Int) {
        let weightParams: [String: Any] = [
            "weight": weight,
            "weightMetric": weightMetric
        ]
        UserDefaults.standard.set(weightParams, forKey: userWeightKey)

        self.weight = weight
        self.weightMetric = weightMetric
    }

    static func getWeight() -> (Double, Int) {
        if (!isKeyPresentInUserDefaults(key: userWeightKey)) {
            return (DEFAULT_WEIGHT, 0)
        }

        guard let weightParams = UserDefaults.standard.dictionary(forKey: userWeightKey) else {
            fatalError("no weight key defined in UserDefaults \(userWeightKey)")
        }
        guard let weight = weightParams["weight"] as? Double else {
            fatalError("weight cannot be cast to Double")
        }
        guard let weightMetric = weightParams["weightMetric"] as? Int else {
            fatalError("weightMetric cannot be cast to Int")
        }

        return (weight, weightMetric)
    }

    func saveHeight(_ heightSize: HeightSize) {
        let heightFeet = heightSize.feet
        let heightInches = heightSize.inches
        let heightCentimeters = heightSize.centimeters
        let heightMetric = heightSize.unit

        guard let metricIndex = HeightSize.getIndexBy(unit: heightMetric) else {
            fatalError("no metric index defined by unit \(heightMetric)")
        }

        let heightParams = [
            "feet": heightFeet,
            "inches": heightInches,
            "centimeters": heightCentimeters,
            "metric": metricIndex
        ]
        UserDefaults.standard.set(heightParams, forKey: userHeightKey)
        self.height = heightSize
    }

    static func getHeight() -> HeightSize {
        if (!isKeyPresentInUserDefaults(key: userHeightKey)) {
            return HeightSize(
                feet: DEFAULT_HEIGHT_FEET,
                inches: DEFAULT_HEIGHT_INCHES,
                unit: HeightSize.getUnitBy(index: 0),
                centimeters: DEFAULT_HEIGHT_CENTIMETERS
            )
        }
        guard let heightFeet = UserDefaults.standard.dictionary(forKey: userHeightKey) else {
            fatalError("no height key defined in UserDefaults \(userHeightKey)")
        }
        guard let feet = heightFeet["feet"] as? Int else {
            fatalError("feet cannot be cast to Int")
        }
        guard let inches = heightFeet["inches"] as? Int else {
            fatalError("inches cannot be cast to Int")
        }
        guard let metric = heightFeet["metric"] as? Int else {
            fatalError("metric cannot be cast to Int")
        }
        guard let centimeters = heightFeet["centimeters"] as? Int else {
            fatalError("centimeters cannot be cast to Int")
        }

        let heighSize = HeightSize(
            feet: feet,
            inches: inches,
            unit: HeightSize.getUnitBy(index: metric),
            centimeters: centimeters
        )

        return heighSize
    }

    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    /**
     1 kg / 0.45359237 = 2.2046226218 lb
     */
    static func kgToLbs(kg: Double) -> Double {
        return kg / 0.45359237
    }
    /**
     1 lbs = 1 x 0.45359237 kg
     */
    static func lbsToKg(lbs: Double) -> Double {
        return lbs * 0.45359237
    }

    /**
     1 ft = 0.3048 m
     1 in = 0.0254 m
     */
    static func feetToCm(feet: Int, inches: Int) -> Double {
        let meters = Double(feet) * 0.3048 + Double(inches) * 0.0254

        return meters * 100
    }

    static func getUserWeight() -> Double {
        let weight = UserData.default.weightMetric == 0
            ? UserData.lbsToKg(lbs: UserData.default.weight)
            : UserData.default.weight

        return weight
    }

    static func getUserHeight() -> Double {
        let heighSize = UserData.default.height

        if (heighSize.unit == HeightSize.Unit.cm) {
            return Double(heighSize.centimeters)
        } else if (heighSize.unit == HeightSize.Unit.ft_in) {
            return feetToCm(feet: heighSize.feet, inches: heighSize.inches)
        } else {
            fatalError("getUserHeight no option")
        }
    }
    
    func saveAge(_ age: Int) {
        UserDefaults.standard.set(age, forKey: userAgeKey)
        self.age = age
    }

    static func getAge() -> Int {
        let age = UserDefaults.standard.integer(forKey: userAgeKey)
        if (age <= 0) {
            let newAge = DEFAULT_AGE
            UserDefaults.standard.set(newAge, forKey: userAgeKey)
            return newAge
        }
        return age
    }

    func saveBiologicalSex(_ biologicalSex: Int) {
        UserDefaults.standard.set(biologicalSex, forKey: userBiologicalSexKey)
        self.biologicalSex = biologicalSex
    }

    static func getBiologicalSex() -> Int {
        let biologicalSex = UserDefaults.standard.integer(forKey: userBiologicalSexKey)
        return biologicalSex
    }

    func saveFitnessLevel(_ fitnessLevel: Int) {
        UserDefaults.standard.set(fitnessLevel, forKey: userFitnessLevelKey)
        self.fitnessLevel = fitnessLevel
    }

    static func getFitnessLevel() -> Int {
        let fitnessLevel = UserDefaults.standard.integer(forKey: userFitnessLevelKey)
        return fitnessLevel
    }

    func isMetricSettingsUsed() -> Bool {
        return self.weightMetric == 1
    }

    func convertToMetricIfNeeded(lbsOrKg: Double?) -> Double? {
        if (isMetricSettingsUsed()) {
            return lbsOrKg
        }

        guard let weight = lbsOrKg else {
            return nil
        }

        return UserData.kgToLbs(kg: weight)
    }

    func getWeightLabel() -> String {
        return UserData.weightMetricLables[self.weightMetric]
    }
}
