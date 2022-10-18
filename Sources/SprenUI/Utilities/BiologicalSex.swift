//
//  BiologicalSex.swift
//  
//
//  Created by Keith Carolus on 10/18/22.
//

import Foundation

public enum BiologicalSex: String, CaseIterable {
    case male
    case female
    case other
    
    static func getPlural(_ gender: Self) -> String {
        switch gender {
        case .male: return "men"
        case .female: return "women"
        case .other: return "people"
        }
    }
}
