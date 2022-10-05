//
//  HeightSize.swift
//  SprenInternal
//
//  Created by nick on 29.07.2022.
//

import SwiftUI

struct HeightSize {
    let feet: Int
    let inches: Int
    let unit: Unit
    let centimeters: Int

    enum Unit: CustomStringConvertible, CaseIterable {
        case ft_in, cm

        var description : String {
            switch self {
            case .cm: return "cm"
            case .ft_in: return "ft/in"
            }
        }
    }
    
    static func getUnitBy(index: Int) -> Unit {
        return Unit.allCases[index]
    }
    
    static func getIndexBy(unit: Unit) -> Int {
        return unit.index!
    }
}
