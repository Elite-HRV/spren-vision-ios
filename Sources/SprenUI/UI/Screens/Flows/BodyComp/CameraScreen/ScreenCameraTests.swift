//
//  ScreenCameraTests.swift
//  SprenInternal
//
//  Created by Fernando on 8/18/22.
//

import SwiftUI

struct ScreenCameraTests: View {
    
    var currentFrame: UIImage?
    var leftWrist: CGPoint?
    var rightWrist: CGPoint?
    var leftAnkle: CGPoint?
    var rightAnkle: CGPoint?
    
    var body: some View {
        if let currentFrame = currentFrame {
            ZStack {
                Image(uiImage: currentFrame).resizable()
                    .aspectRatio(contentMode: .fill)
            }.frame(width: UIScreen.main.bounds.width).edgesIgnoringSafeArea(.all).opacity(0.8)
        }
        
//        display circles on the points
        if let leftWrist = leftWrist, let rightWrist = rightWrist, let leftAnkle = leftAnkle, let rightAnkle = rightAnkle {
            ZStack {
                Path { path in

                    let p1 = CGPoint(x: leftWrist.x-1, y: leftWrist.y-1)
                    let p2 = CGPoint(x: leftWrist.x+1, y: leftWrist.y+1)

                    path.move(to: p1)
                    path.addLine(to: p2)

                    let p3 = CGPoint(x: rightWrist.x-1, y: rightWrist.y-1)
                    let p4 = CGPoint(x: rightWrist.x+1, y: rightWrist.y+1)

                    path.move(to: p3)
                    path.addLine(to: p4)

                    let p5 = CGPoint(x: leftAnkle.x-1, y: leftAnkle.y-1)
                    let p6 = CGPoint(x: leftAnkle.x+1, y: leftAnkle.y+1)

                    path.move(to: p5)
                    path.addLine(to: p6)

                    let p7 = CGPoint(x: rightAnkle.x-1, y: rightAnkle.y-1)
                    let p8 = CGPoint(x: rightAnkle.x+1, y: rightAnkle.y+1)

                    path.move(to: p7)
                    path.addLine(to: p8)
                }.stroke(.green, style: StrokeStyle(lineWidth: 8, lineCap: .round, lineJoin: .round))
            }.frame(width: UIScreen.main.bounds.width).edgesIgnoringSafeArea(.all)
        }
    }
}

struct ScreenCameraTests_Previews: PreviewProvider {
    static var previews: some View {
        ScreenCameraTests()
    }
}
