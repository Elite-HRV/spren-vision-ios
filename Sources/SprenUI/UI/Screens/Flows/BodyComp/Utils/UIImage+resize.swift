//
//  UIImage+resize.swift
//  SprenInternal
//
//  Created by nick on 30.08.2022.
//

import UIKit

extension UIImage {
    func resized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
