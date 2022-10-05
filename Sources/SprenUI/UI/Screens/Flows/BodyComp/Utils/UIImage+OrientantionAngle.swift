//
//  UIImage+OrientantionAngle.swift
//  SprenInternal
//
//  Created by nick on 19.08.2022.
//

import SwiftUI

extension UIImage {
    func getRotationAngle() -> Angle {
        switch imageOrientation {
        case .left:
            return Angle(degrees: 270)
        case .leftMirrored:
            return Angle(degrees: 270)
         case .right:
            return Angle(degrees: 90)
        case .rightMirrored:
            return Angle(degrees: 90)
        case .down:
            return Angle(degrees: 180)
        case .downMirrored:
            return Angle(degrees: 180)
        default:
            return Angle(degrees: 0)
        }
    }
}
