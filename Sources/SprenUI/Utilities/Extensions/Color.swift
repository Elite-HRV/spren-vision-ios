//
//  Color.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/25/22.
//

import Foundation
import SwiftUI

extension Color {
    
    static let sprenPurple = Color(red: 84/255, green: 69/255, blue: 174/255)
    static let sprenPink = Color(red: 248/255, green: 73/255, blue: 115/255)
    
    static var sprenUIPrimaryColor: Color {
        SprenUI.config.primaryColor ?? sprenPurple
    }
    static var sprenUISecondaryColor: Color {
        SprenUI.config.secondaryColor ?? sprenPink
    }
    
    static let sprenGreen = Color(red: 39/255, green: 207/255, blue: 113/255)
    static let sprenGray = Color(red: 181/255, green: 181/255, blue: 181/255)
    
    static let offWhite = Color(red: 250/255, green: 250/255, blue: 250/255)
    static let offBlack = Color(red: 7/255, green: 7/255, blue: 7/255)
    
    static let readinessRed = Color(red: 255/255, green: 61/255, blue: 0/255)
    static let readinessAmber = Color(red: 255/255, green: 135/255, blue: 0/255)
    static let readinessGreen = Color(red: 13/255, green: 193/255, blue: 139/255)
    
    static let sprenBodyCompShaddowLight = Color(red: 169/255, green: 170/255, blue: 187/255, opacity: 0.1)
    static let sprenBodyCompShaddowDark = Color(red: 0.708, green: 0.720, blue: 0.705, opacity: 0.81)
    
    static let sprenBodyCompBackgroundLight = Color(red: 0.965, green: 0.965, blue: 0.965)
    static let sprenBodyCompBackgroundDark = Color(red: 0, green: 0, blue: 0)
    
    static let sprenBodyCompBlackLight = Color(red: 0.102, green: 0.137, blue: 0.239)
    static let sprenBodyCompBlackDark = Color(red: 1, green: 1, blue: 1)
    
    static let sprenBodyCompGreenLight = Color(red: 0.051, green: 0.757, blue: 0.545)
    static let sprenBodyCompGreenDark = Color(red: 0.055, green: 0.882, blue: 0.635)
    
    static let sprenBodyCompGrayLight = Color(red: 0.486, green: 0.490, blue: 0.580)
    static let sprenBodyCompGrayDark = Color(red: 1, green: 1, blue: 1, opacity: 0.7)
    
    static let sprenBodyCompLightGrayLight = Color(red: 0.910, green: 0.910, blue: 0.910)
    static let sprenBodyCompLightGrayDark = Color(red: 0.486, green: 0.490, blue: 0.580)
    
    static let sprenBodyCompPinkLight = Color(red: 0.898, green: 0.341, blue: 0.459)
    static let sprenBodyCompPinkDark = Color(red: 0.898, green: 0.341, blue: 0.459)
    
    static let sprenBodyCompPurpleLight = Color(red: 0.322, green: 0.275, blue: 0.659)
    static let sprenBodyCompPurpleDark = Color(red: 0.502, green: 0.204, blue: 0.980)
    
    static let sprenBodyCompBlack20 = Color(red: 0, green: 0, blue: 0, opacity: 0.2)
    
    static let sprenBodyCompLightGray2Light = Color(red: 0.584, green: 0.600, blue: 0.643)
    static let sprenBodyCompLightGray2Dark = Color(red: 0.702, green: 0.702, blue: 0.702)
    
    static let sprenBodyCompDarkGray = Color(red: 34/255, green: 33/255, blue: 48/255)
    
    static let sprenBodyCompRedLight = Color(red: 0.898, green: 0.341, blue: 0.459)
    static let sprenBodyCompRedDark = Color(red: 0.898, green: 0.341, blue: 0.459)
}
