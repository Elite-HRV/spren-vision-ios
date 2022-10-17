//
//  Color.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/25/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let sprenPink = Color(red: 248/255, green: 73/255, blue: 115/255)
    static let sprenPurple = Color(red: 84/255, green: 69/255, blue: 174/255)
    
    static var sprenUIColor1: Color {
        SprenUI.config.color1 ?? sprenPink
    }
    static var sprenUIColor2: Color {
        SprenUI.config.color2 ?? sprenPurple
    }
    
    static let sprenGreen = Color(red: 39/255, green: 207/255, blue: 113/255)
    static let sprenGray = Color(red: 181/255, green: 181/255, blue: 181/255)
    
    static let offWhite = Color(red: 250/255, green: 250/255, blue: 250/255)
    static let offBlack = Color(red: 7/255, green: 7/255, blue: 7/255)
    
    static let readinessRed = Color(red: 255/255, green: 61/255, blue: 0/255)
    static let readinessAmber = Color(red: 255/255, green: 135/255, blue: 0/255)
    static let readinessGreen = Color(red: 13/255, green: 193/255, blue: 139/255)
    
}
