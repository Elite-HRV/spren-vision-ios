//
//  RRBar.swift
//  
//
//  Created by Fernando on 9/28/22.
//

import SwiftUI

struct RRBar: View {
    
    let lineHeight = Autoscale.scaleFactor * 10
    let triangleSize = Autoscale.scaleFactor * 13
    let breathingRate: Double
    
    var body: some View {
        GeometryReader { geometry in
            
            let valuePercent = Double(breathingRate) / 32
            let width = geometry.size.width
            
            VStack(spacing: 0) {
                HStack {
                    Spacer(minLength: ((valuePercent*width)-10))
                    Image(systemName: "arrowtriangle.down.fill")
                        .resizable()
                        .frame(width: triangleSize, height: triangleSize)
                        .foregroundColor(getArrowColor())
                        .padding(.bottom, 3)
                    Spacer(minLength: ((1-valuePercent)*width)-10)
                }
                .frame(alignment: .center)
                
                ZStack {
                    Rectangle()
                        .fill(
                            Color("LightGrey", bundle: .module)
                        )
                        .frame(height: lineHeight)
                        .cornerRadius(lineHeight/2)
                    
                    HStack {
                        Rectangle()
                            .fill(
                                LinearGradient(gradient: Gradient(stops: [
                                    .init(color: getBarStartColor(), location: 0),
                                    .init(color: getBarEndColor(), location: 1),
                                ]),
                                               startPoint: .leading,
                                               endPoint: .trailing
                                )
                            )
                            .frame(height: lineHeight)
                            .cornerRadius(lineHeight/2)
                        Spacer(minLength: ((1-valuePercent)*width))
                    }
                    
                    HStack {
                        Spacer(minLength: (12/32)*width)
                        VStack {}.frame(width: 2, height: lineHeight).background(Color("DarkGrey", bundle: .module))
                        Spacer(minLength: (8/32)*width)
                        VStack {}.frame(width: 2, height: lineHeight).background(Color("DarkGrey", bundle: .module))
                        Spacer(minLength: (11/32)*width)
                        Spacer()
                    }
                }
                
                HStack {
                    Text("Normal (12-20 rpm)")
                        .font(.sprenLabel)
                        .foregroundColor(Color.gray)
                        .padding(.top, 2)
                }
                
            }
        }
        .frame(height: 60)
    }
}

extension RRBar {
    func getArrowColor() -> Color {
        if (breathingRate < 12 || breathingRate > 20){
            return Color("Yellow", bundle: .module)
        }
        
        return Color.green
    }
    
    func getBarStartColor() -> Color {
        if (breathingRate < 12 || breathingRate > 20){
            return Color("LightYellow", bundle: .module)
        }
        
        return Color.green
    }
    
    func getBarEndColor() -> Color {
        if (breathingRate < 12 || breathingRate > 20){
            return Color("Yellow", bundle: .module)
        }
        
        return Color.green
    }
}

struct RRBar_Previews: PreviewProvider {
    static var previews: some View {
        RRBar(breathingRate: 12)
    }
}
