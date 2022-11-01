//
//  File.swift
//  
//
//  Created by Fernando on 11/1/22.
//

import Foundation
import SwiftUI

public func getColor(colorScheme: ColorScheme, light: Color, dark: Color) -> Color {
    return colorScheme == ColorScheme.light ? light : dark
}
