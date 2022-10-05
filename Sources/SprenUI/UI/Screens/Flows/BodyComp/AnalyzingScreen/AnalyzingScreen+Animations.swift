//
//  AnalyzingScreen+Animations.swift
//  SprenInternal
//
//  Created by nick on 15.08.2022.
//

import SwiftUI

extension AnalyzingScreen {
    func handleAnimation() {
        let frameSize = getFrameSize()
        withAnimation(Animation.easeInOut(duration: 2).repeatForever()) {
            animationModel.lineOffset = frameSize.height - Autoscale.convert(4)
            animationModel.gradientY = frameSize.height
        }
    }
}
