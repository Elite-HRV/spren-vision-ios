//
//  Autoscale.swift
//  SprenUI
//
//  Created by Keith Carolus on 2/8/22.
//

import Foundation
import CoreGraphics
import UIKit
import DeviceKit

class Autoscale {
    
    static let otherWeirdos: [Device] = [
        .iPhone6s,
        .iPhone7,
        .iPhone8,
        .iPhoneSE2,
        .iPhone11,
        .iPhone13Mini,
        .simulator(.iPhone6s),
        .simulator(.iPhone7),
        .simulator(.iPhone8),
        .simulator(.iPhoneSE2),
        .simulator(.iPhone11),
        .simulator(.iPhone13Mini),
    ]
    
    static var scale = UIScreen.main.scale
    static var scaleFactor: CGFloat {
        func deviceOrSimulator(_ device1: Device, _ device2: Device) -> Bool {
            return device1 == device2 || device1 == .simulator(device2)
        }
        
        let device = Device.current
        if deviceOrSimulator(device, .iPhoneSE) {
            return 0.75
        }
        if deviceOrSimulator(device, .iPhoneXR) {
            return 1.1
        }
        if device.isOneOf(otherWeirdos) {
            return 0.9
        }
        
        return 1
    }
    static var padding: CGFloat = 16 * scaleFactor
    static var headingHeight = 60 * scaleFactor
    
    static func convert(_ value: CGFloat) -> CGFloat {
        switch scale - 2.0 {
            case 1:
            return value * (458/326)
            default:
                return value
        }
    }
}
