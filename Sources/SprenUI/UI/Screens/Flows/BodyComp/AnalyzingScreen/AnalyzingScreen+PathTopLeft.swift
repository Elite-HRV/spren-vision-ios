//
//  AnalyzingScreen+Path.swift
//  SprenInternal
//
//  Created by nick on 04.08.2022.
//
import SwiftUI

extension AnalyzingScreen {
    func pathTopLeft() -> some View {
        Path { path in
            let p1 = CGPoint(x: Autoscale.convert(25), y: Autoscale.convert(100))
            let (topLeftPoint, _, _, _) = getCorners()
            let p3 = CGPoint(x: Autoscale.convert(50), y: Autoscale.convert(75))
            let p4 = CGPoint(x: Autoscale.convert(75), y: Autoscale.convert(50))

            path.move(to: p1)
            path.addLine(to: topLeftPoint)
            path.addArc(center: p3, radius: Autoscale.convert(25), startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
            path.addLine(to: p4)

        }.stroke(Color("AppGreen", bundle: .module), style: StrokeStyle(lineWidth: Autoscale.convert(4), lineCap: .round, lineJoin: .round))
    }
}
