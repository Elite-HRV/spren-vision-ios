//
//  Demographics.swift
//  
//
//  Created by Keith Carolus on 10/18/22.
//

import Foundation
import SwiftUI

class Demographics {
    
//    static let hrvClassifications = [
//        "Excellent",
//        "Very Good",
//        "Above Average",
//        "Average",
//        "Below Average",
//        "Poor"
//    ]
//
//    static let hrClassifications = [
//        "Athlete",
//        "Very Good",
//        "Above Average",
//        "Average",
//        "Below Average",
//        "Poor"
//    ]
    
//    static let colors = [
//        "DemographicGreen",
//        "DemographicMediumGreen",
//        "DemographicLightGreen",
//        "DemographicYellow",
//        "DemographicOrange",
//        "DemographicRed"
//    ]
    
//    static func hr(value: Double, age: Int?, gender: BiologicalSex?) -> (classification: String, rangeLabels: [String], rangeIndex: Int) {
//
//        var rangePairs = [(47,56), (57,63), (64,70), (71,78), (79,86), (87,97)]
//
//        if let age = age, gender == nil {
//            if age > 15 && age < 20 {
//                rangePairs = [(47,57),(58,63),(64,72),(73,81),(82,89),(90,100)]
//            }
//            if age > 19 && age < 40 {
//                rangePairs = [(47,56),(57,63),(64,70),(71,78),(79,86),(87,97)]
//            }
//            if age > 39 && age < 60 {
//                rangePairs = [(46,56),(57,61),(62,69),(70,77),(78,85),(86,95)]
//            }
//            if age > 59 {
//                rangePairs = [(46,56),(57,61),(62,69),(70,76),(77,85),(86,97)]
//            }
//        }
//
//        if let age = age, gender == .female {
//            if age > 15 && age < 20 {
//                rangePairs = [(50,61),(62,68),(69,76),(77,84),(85,93),(94,102)]
//            }
//
//            if age > 19 && age < 40 {
//                rangePairs = [(52,59),(60,65),(66,73),(74,81),(82,88),(89,98)]
//            }
//
//            if age > 39 && age < 60 {
//                rangePairs = [(51,58),(59,63),(64,70),(71,78),(79,85),(86,96)]
//            }
//
//            if age > 59 {
//                rangePairs = [(52,58),(59,63),(64,69),(70,77),(78,85),(86,95)]
//            }
//        }
//
//        if let age = age, gender == .male || gender == .other {
//            if age > 15 && age < 20 {
//                rangePairs = [(46,55),(56,60),(61,68),(69,77),(78,86),(87,94)]
//            }
//            if age > 19 && age < 40 {
//                rangePairs = [(47,54),(55,60),(61,68),(69,75),(76,83),(84,94)]
//            }
//            if age > 39 && age < 60 {
//                rangePairs = [(46,54),(55,60),(61,67),(68,76),(77,84),(85,94)]
//            }
//            if age > 59 {
//                rangePairs = [(45,53),(54,59),(60,66),(67,74),(75,83),(84,97)]
//            }
//        }
//
//        var index = 0
//        let rangeLabels = rangePairs.enumerated().map { (i, range) in
//            let (rangeStart, rangeEnd) = range
//            if Double(rangeEnd) <= value {
//                index = i
//            }
//            return "\(rangeStart)-\(rangeEnd)"
//        }
//
//        return (hrClassifications[index], rangeLabels, index)
//    }
//
//    static func hrv(value: Double, age: Int?, gender: BiologicalSex?) -> (classification: String, rangeLabels: [String], rangeIndex: Int) {
//        var rangePairs = [(72,100),(66,71),(60,65),(53,59),(46,52),(1,45)]
//
//        if let age = age, gender == .female {
//            if age > 17 && age < 30 {
//                rangePairs = [(73,78),(70,73),(65,70),(59,65),(50,59),(30,50)]
//            }
//
//            if age > 29 && age < 40 {
//                rangePairs = [(72,79),(68,72),(61,68),(55,61),(48,55),(36,48)]
//            }
//
//            if age > 39 && age < 50 {
//                rangePairs = [(69,76),(64,69),(58,64),(51,58),(43,51),(32,43)]
//            }
//
//            if age > 49 && age < 60 {
//                rangePairs = [(67,74),(62,67),(56,62),(50,56),(45,50),(35,45)]
//            }
//
//            if age > 59 && age < 70 {
//                rangePairs = [(65,74),(59,65),(53,59),(47,53),(40,47),(28,40)]
//            }
//
//            if age > 69 {
//                rangePairs = [(65,73),(59,65),(51,59),(42,51),(38,42),(32,38)]
//            }
//        }
//
//        if let age = age, gender == .male || gender == .other {
//            if age > 17 && age < 30 {
//                rangePairs = [(75,100),(71,75),(67,71),(61,67),(53,61),(41,53)]
//            }
//
//            if age > 29 && age < 40 {
//                rangePairs = [(72,100),(69,72),(63,69),(57,63),(51,57),(38,51)]
//            }
//
//            if age > 39 && age < 50 {
//                rangePairs = [(70,100),(66,70),(60,66),(54,60),(48,54),(35,48)]
//            }
//
//            if age > 49 && age < 60 {
//                rangePairs = [(68,100),(62,68),(56,62),(50,56),(45,50),(33,45)]
//            }
//
//            if age > 59 && age < 70 {
//                rangePairs = [(67,100),(61,67),(54,61),(48,54),(42,48),(30,42)]
//            }
//
//            if age > 69 {
//                rangePairs = [(69,100),(62,69),(55,62),(47,55),(39,47),(26,39)]
//            }
//        }
//
//        var index = 0
//        let rangeLabels = rangePairs.enumerated().map { (i, range) in
//            let (rangeStart, rangeEnd) = range
//            if Double(rangeEnd) <= value {
//                index = i
//            }
//            return "\(rangeStart)-\(rangeEnd)"
//        }
//
//        return (hrvClassifications[index], rangeLabels, index)
//    }
//
//    static func rr(value: Double) -> (classification: String, color: Color)? {
//        switch value {
//        case ..<12:
//            return ("abnormally low", Color("Yellow", bundle: .module))
//        case 12..<20:
//            return ("normal", Color("Green", bundle: .module))
//        case 20...:
//            return ("abnormally high", Color("Yellow", bundle: .module))
//        default:
//            return nil
//        }
//    }
    
}
