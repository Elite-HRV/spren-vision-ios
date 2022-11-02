//
//  AnalyzingScreen+PathBottomRight.swift
//  SprenInternal
//
//  Created by nick on 04.08.2022.
//

import SwiftUI

extension AnalyzingScreen {
    func pathBottomRight() -> some View {
        Path { path in
            let p1 = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(25), y: UIScreen.main.bounds.height * AnalyzingScreen.imageHeightPercent - Autoscale.convert(25))
            let (_, _, _, bottomRightPoint) = getCorners()
            let p3 = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(50), y: UIScreen.main.bounds.height * AnalyzingScreen.imageHeightPercent - Autoscale.convert(-25))
            let p4 = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(75), y: UIScreen.main.bounds.height * AnalyzingScreen.imageHeightPercent - Autoscale.convert(-50))

            path.move(to: p1)
            path.addLine(to: bottomRightPoint)
            path.addArc(center: p3, radius: Autoscale.convert(25), startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
            path.addLine(to: p4)
        }.stroke(Color.sprenUIColor1, style: StrokeStyle(lineWidth: Autoscale.convert(4), lineCap: .round, lineJoin: .round))
    }
}
