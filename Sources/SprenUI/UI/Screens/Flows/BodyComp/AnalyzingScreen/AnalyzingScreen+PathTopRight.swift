//
//  AnalyzingScreen+PathTopRight.swift
//  SprenInternal
//
//  Created by nick on 04.08.2022.
//

import SwiftUI

extension AnalyzingScreen {
    func pathTopRight() -> some View {
        Path { path in
            let p1 = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(25), y: Autoscale.convert(100))
            let (_, topRightPoint, _, _) = getCorners()
            let p3 = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(50), y: Autoscale.convert(75))
            let p4 = CGPoint(x: UIScreen.main.bounds.width - Autoscale.convert(75), y: Autoscale.convert(50))

            path.move(to: p1)
            path.addLine(to: topRightPoint)
            path.addArc(center: p3, radius: Autoscale.convert(25), startAngle: .degrees(0), endAngle: .degrees(270), clockwise: true)
            path.addLine(to: p4)

        }.stroke(Color.sprenUISecondaryColor, style: StrokeStyle(lineWidth: Autoscale.convert(4), lineCap: .round, lineJoin: .round))
    }
}
