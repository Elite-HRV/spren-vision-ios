//
//  UIImage+rotate.swift
//  SprenInternal
//
//  Created by nick on 19.08.2022.
//

import SwiftUI

extension UIImage {
    func rotated() -> UIImage {
        var rotatedImage = UIImage()
        guard let cgImage = cgImage else {
            print("could not rotate image")
            return self
        }
        switch imageOrientation {
        case .right:
            rotatedImage = UIImage(cgImage: cgImage, scale: scale, orientation: .right)
        case .down:
            rotatedImage = UIImage(cgImage: cgImage, scale: scale, orientation: .left)
        case .left:
            rotatedImage = UIImage(cgImage: cgImage, scale: scale, orientation: .up)
        default:
            rotatedImage = UIImage(cgImage: cgImage, scale: scale, orientation: .right)
        }
        
        return rotatedImage
    }
}
