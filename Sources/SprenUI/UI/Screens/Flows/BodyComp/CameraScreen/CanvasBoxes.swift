//
//  Canvas.swift
//  SprenInternal
//
//  Created by Fernando on 8/10/22.
//

import SwiftUI

struct CanvasBoxes: View {
    
    let leftWrist: CGPoint?
    let rightWrist: CGPoint?
    let leftAnkle: CGPoint?
    let rightAnkle: CGPoint?
    
    let armsHeight = UIScreen.main.bounds.height/4
    let armsRightWidth = UIScreen.main.bounds.width
    let leftWidth = UIScreen.main.bounds.width / 2
    let rightWidth = UIScreen.main.bounds.width / 2 + 75
    
    func isLeftWristIn() -> Bool {
        if(leftWrist == nil) {
            return false
        }
        
        var topPadding = 0.0
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            topPadding = window!.safeAreaInsets.top
        }
        
        if(leftWrist!.x > 15 && leftWrist!.x < 90 && leftWrist!.y > armsHeight + topPadding && leftWrist!.y < armsHeight + topPadding + 89){
            return true
        }
        
        return false
    }
    
    func isRightWristIn() -> Bool {
        if(rightWrist == nil) {
            return false
        }
        
        var topPadding = 0.0
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            topPadding = window!.safeAreaInsets.top
        }
        
        if(rightWrist!.x > armsRightWidth - 90 && rightWrist!.x < armsRightWidth - 16 && rightWrist!.y > armsHeight + topPadding && rightWrist!.y < armsHeight + topPadding + 89){
            return true
        }
        
        return false
    }
    
    func isLeftAnkleIn() -> Bool {
        if(leftAnkle == nil) {
            return false
        }
        
        var topPadding = 0.0
        var bottomPadding = 0.0
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            topPadding = window!.safeAreaInsets.top
            bottomPadding = window!.safeAreaInsets.bottom
        }
        
        let bottomHeight = UIScreen.main.bounds.height + topPadding - Autoscale.convert(bottomPadding + 180)
        
        if(leftAnkle!.x > leftWidth - 49 && leftAnkle!.x < rightWidth - 27 && leftAnkle!.y > bottomHeight - 107 && leftAnkle!.y < bottomHeight - 6){
            return true
        }
        
        return false
    }
    
    func isRightAnkleIn() -> Bool {
        if(rightAnkle == nil) {
            return false
        }
        
        var topPadding = 0.0
        var bottomPadding = 0.0
        
        if #available(iOS 13.0, *) {
            let window = UIApplication.shared.windows.first
            topPadding = window!.safeAreaInsets.top
            bottomPadding = window!.safeAreaInsets.bottom
        }
        
        let bottomHeight = UIScreen.main.bounds.height + topPadding - Autoscale.convert(bottomPadding + 180)
        
        if(rightAnkle!.x > leftWidth - 49 && rightAnkle!.x < rightWidth - 27 && rightAnkle!.y > bottomHeight - 107 && rightAnkle!.y < bottomHeight - 6){
            return true
        }
        
        return false
    }
    
    func isLeftRightAnkleIn() -> Bool {
        return isLeftAnkleIn() && isRightAnkleIn()
    }

    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ZStack {
                    Path { path in
                        let p1 = CGPoint(x: 40, y: armsHeight)
                        let p2 = CGPoint(x: 16, y: armsHeight + 24)
                        let p3 = CGPoint(x: 24, y: armsHeight + 8)
                        let p4 = CGPoint(x: 40, y: armsHeight)

                        path.move(to: p1)
                        path.addLine(to: p4)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
                        path.addLine(to: p2)
                    }.stroke(isLeftWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        let p1 = CGPoint(x: 66, y: armsHeight)
                        let p2 = CGPoint(x: 90, y: armsHeight + 24)
                        let p3 = CGPoint(x: 82, y: armsHeight + 8)
                        let p4 = CGPoint(x: 82, y: armsHeight)

                        path.move(to: p1)
                        path.addLine(to: p4)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
                        path.addLine(to: p2)
                    }.stroke(isLeftWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        let p1 = CGPoint(x: 16, y: armsHeight + 65)
                        let p2 = CGPoint(x: 16, y: armsHeight + 80)
                        let p3 = CGPoint(x: 24, y: armsHeight + 80)
                        let p4 = CGPoint(x: 40, y: armsHeight + 88)

                        path.move(to: p1)
                        path.addLine(to: p2)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                        path.addLine(to: p4)
                    }.stroke(isLeftWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        let p1 = CGPoint(x: 90, y: armsHeight + 65)
                        let p2 = CGPoint(x: 90, y: armsHeight + 80)
                        let p3 = CGPoint(x: 82, y: armsHeight + 80)
                        let p4 = CGPoint(x: 66, y: armsHeight + 88)

                        path.move(to: p1)
                        path.addLine(to: p2)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
                        path.addLine(to: p4)
                    }.stroke(isLeftWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    CanvasCircles(x: 53, y: armsHeight + 44, size1: 50, size2: 32, size3: 10, action: isLeftWristIn)
                }
                
                ZStack {
                    //Top right
                    Path { path in
                        let p1 = CGPoint(x: armsRightWidth - 66, y: armsHeight)
                        let p2 = CGPoint(x: armsRightWidth - 90, y: armsHeight + 24)
                        let p3 = CGPoint(x: armsRightWidth - 82, y: armsHeight + 8)
                        let p4 = CGPoint(x: armsRightWidth - 66, y: armsHeight)

                        path.move(to: p1)
                        path.addLine(to: p4)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
                        path.addLine(to: p2)
                    }.stroke(isRightWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        let p1 = CGPoint(x: armsRightWidth - 40, y: armsHeight)
                        let p2 = CGPoint(x: armsRightWidth - 16, y: armsHeight + 24)
                        let p3 = CGPoint(x: armsRightWidth - 24, y: armsHeight + 8)
                        let p4 = CGPoint(x: armsRightWidth - 24, y: armsHeight)

                        path.move(to: p1)
                        path.addLine(to: p4)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
                        path.addLine(to: p2)
                    }.stroke(isRightWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))

                    Path { path in
                        let p1 = CGPoint(x: armsRightWidth - 90, y: armsHeight + 65)
                        let p2 = CGPoint(x: armsRightWidth - 90, y: armsHeight + 80)
                        let p3 = CGPoint(x: armsRightWidth - 82, y: armsHeight + 80)
                        let p4 = CGPoint(x: armsRightWidth - 66, y: armsHeight + 88)

                        path.move(to: p1)
                        path.addLine(to: p2)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                        path.addLine(to: p4)
                    }.stroke(isRightWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))

                    Path { path in
                        let p1 = CGPoint(x: armsRightWidth - 16, y: armsHeight + 65)
                        let p2 = CGPoint(x: armsRightWidth - 16, y: armsHeight + 80)
                        let p3 = CGPoint(x: armsRightWidth - 24, y: armsHeight + 80)
                        let p4 = CGPoint(x: armsRightWidth - 40, y: armsHeight + 88)

                        path.move(to: p1)
                        path.addLine(to: p2)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
                        path.addLine(to: p4)
                    }.stroke(isRightWristIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    CanvasCircles(x: armsRightWidth - 53, y: armsHeight + 44, size1: 50, size2: 32, size3: 10, action: isRightWristIn)
                }
                
                ZStack {
                    //Bottom
                    let bottomHeight = UIScreen.main.bounds.height - (geometry.safeAreaInsets.top + geometry.safeAreaInsets.bottom + Autoscale.convert(160))
                    
                    Path { path in
                        let p1 = CGPoint(x: leftWidth - 34, y: bottomHeight - 106)
                        let p2 = CGPoint(x: leftWidth - 50, y: bottomHeight - 82)
                        let p3 = CGPoint(x: leftWidth - 42, y: bottomHeight - 98)
                        let p4 = CGPoint(x: leftWidth - 26, y: bottomHeight - 106)

                        path.move(to: p1)
                        path.addLine(to: p4)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(270), endAngle: .degrees(180), clockwise: true)
                        path.addLine(to: p2)
                    }.stroke(isLeftRightAnkleIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        let p1 = CGPoint(x: rightWidth - 50, y: bottomHeight - 106)
                        let p2 = CGPoint(x: rightWidth - 26, y: bottomHeight - 82)
                        let p3 = CGPoint(x: rightWidth - 34, y: bottomHeight - 98)
                        let p4 = CGPoint(x: rightWidth - 50, y: bottomHeight - 106)

                        path.move(to: p1)
                        path.addLine(to: p4)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(270), endAngle: .degrees(0), clockwise: false)
                        path.addLine(to: p2)
                    }.stroke(isLeftRightAnkleIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    Path { path in
                        let p1 = CGPoint(x: leftWidth - 50, y: bottomHeight - 31)
                        let p2 = CGPoint(x: leftWidth - 50, y: bottomHeight - 15)
                        let p3 = CGPoint(x: leftWidth - 42, y: bottomHeight - 15)
                        let p4 = CGPoint(x: leftWidth - 26, y: bottomHeight - 7)

                        path.move(to: p1)
                        path.addLine(to: p2)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(180), endAngle: .degrees(90), clockwise: true)
                        path.addLine(to: p4)
                    }.stroke(isLeftRightAnkleIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                                        
                    Path { path in
                        let p1 = CGPoint(x: rightWidth - 26, y: bottomHeight - 31)
                        let p2 = CGPoint(x: rightWidth - 26, y: bottomHeight - 15)
                        let p3 = CGPoint(x: rightWidth - 34, y: bottomHeight - 15)
                        let p4 = CGPoint(x: rightWidth - 50, y: bottomHeight - 7)

                        path.move(to: p1)
                        path.addLine(to: p2)
                        path.addArc(center: p3, radius: 8, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
                        path.addLine(to: p4)
                    }.stroke(isLeftRightAnkleIn() ? Color("AppGreen", bundle: .module) : .white, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
                    
                    CanvasCircles(x: leftWidth - 17, y: bottomHeight - 56.5, size1: 30, size2: 19.2, size3: 6, action: isLeftAnkleIn)
                    
                    CanvasCircles(x: leftWidth + 17, y: bottomHeight - 56.5, size1: 30, size2: 19.2, size3: 6, action: isRightAnkleIn)
                }
            }
        }
    }
}

struct CanvasCircles: View {
    var x: CGFloat
    var y: CGFloat
    var size1: CGFloat
    var size2: CGFloat
    var size3: CGFloat
    var action: () -> Bool

    var body: some View {
        GeometryReader { geometry in
            Circle()
                .foregroundColor(action() ? Color("AppGreen", bundle: .module) : .white)
                .opacity(0.5)
                .frame(height: size1)
                .position(x: x, y: y)

            Circle()
                .foregroundColor(action() ? Color("AppGreen", bundle: .module) : .white)
                .opacity(0.5)
                .frame(height: size2)
                .position(x: x, y: y)

            Circle()
                .foregroundColor(action() ? Color("AppGreen", bundle: .module) : .white)
                .frame(height: size3)
                .position(x: x, y: y)
        }
    }
}

struct CanvasBoxes_Previews: PreviewProvider {
    static var previews: some View {
        CanvasBoxes(leftWrist: nil, rightWrist: nil, leftAnkle: nil, rightAnkle: nil)
    }
}
