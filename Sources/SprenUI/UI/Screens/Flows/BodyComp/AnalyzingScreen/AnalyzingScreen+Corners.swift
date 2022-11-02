//
//  AnalyzingScreen+Corners.swift
//  SprenInternal
//
//  Created by nick on 15.08.2022.
//

import SwiftUI

extension AnalyzingScreen {
    func getCorners() -> (CGPoint, CGPoint, CGPoint, CGPoint) {
        let topLeftPoint = CGPoint(x: Autoscale.convert(25), y: Autoscale.convert(75))
        let topRightPoint = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(25), y: Autoscale.convert(75))
        let bottomLeftPoint = CGPoint(x: Autoscale.convert(25), y: UIScreen.main.bounds.height * AnalyzingScreen.imageHeightPercent)
        let bottomRightPoint = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(25), y: UIScreen.main.bounds.height * AnalyzingScreen.imageHeightPercent)

        return (topLeftPoint, topRightPoint, bottomLeftPoint, bottomRightPoint)
    }

    func getFrameSize() -> CGSize {
        let size = CGSize(width: UIScreen.main.bounds.width - Autoscale.convert(46), height: UIScreen.main.bounds.height * AnalyzingScreen.imageHeightPercent + Autoscale.convert(4) )

        return size
    }
}
