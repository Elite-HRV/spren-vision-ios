//
//  AnalyzingScreen+Line.swift
//  SprenInternal
//
//  Created by nick on 16.08.2022.
//

import SwiftUI

extension AnalyzingScreen {
    func line() -> some View {
        let size = getFrameSize()

        return VStack(spacing: 0) {
                Spacer()
                Rectangle()
//                        .fill(Color.red)
                    .fill(Color.sprenUISecondaryColor)
                    .cornerRadius(Autoscale.convert(2))
                    .frame(width: size.width - Autoscale.convert(4), height: Autoscale.convert(4), alignment: .center)
                    .offset(x: 0, y: -(animationModel.lineOffset))
            }
//            .background(Color.red)
            .cornerRadius(Autoscale.convert(25))
            .frame(width: size.width, height: size.height, alignment: .bottom)
            .padding([.top], Autoscale.convert(48))
    }

    func gradient() -> some View {
        let size = getFrameSize()

        let gradientStart = Color.sprenUISecondaryColor.opacity(0)
        let gradientEnd = Color.sprenUISecondaryColor.opacity(0.4)

        return VStack(spacing: 0) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(
                        LinearGradient(gradient: Gradient(colors: [gradientStart, gradientEnd]), startPoint: .bottom, endPoint: .top)
                    )
                    .frame(width: size.width - Autoscale.convert(8), height: animationModel.gradientY, alignment: .center)
            }
//            .background(Color.red)
            .frame(width: size.width - Autoscale.convert(8), height: size.height, alignment: .bottom)
        }
        .cornerRadius(Autoscale.convert(23))
        .padding([.top], Autoscale.convert(48))
    }
}
