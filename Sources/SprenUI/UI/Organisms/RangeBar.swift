//
//  RangeBar.swift
//  SprenUI
//
//  Created by Keith Carolus on 2/4/22.
//

import SwiftUI

struct RangeBar: View {
    
    let value: Int
    let rangeStart = 24
    let rangeEnd = 93
    let rangeCenter = 58
    
    let youTextWidth = Autoscale.scaleFactor * 60
    let labelWidth = Autoscale.scaleFactor * 30
    let lineHeight = Autoscale.scaleFactor * 12
    let triangleSize = Autoscale.scaleFactor * 15
    
    var body: some View {
        
        let valuePercent  = Double(value)       / 100
        let startPercent  = Double(rangeStart)  / 100
        let endPercent    = Double(rangeEnd)    / 100
        let centerPercent = Double(rangeCenter) / 100
        
        VStack(spacing: 0) {
            GeometryReader { geometry in
                let width = geometry.size.width
                let paddedWidth = width-30
                
                VStack(spacing: 0) {
                    // you
                    ZStack {
                        HStack {
                            Spacer(minLength: (valuePercent*width)-(youTextWidth/2))
                            
                            VStack(spacing: 0) {
                                Text("You, \(value)")
                                    .font(.sprenParagraph)
                                    .padding(.bottom, 5)
                                Image(systemName: "arrowtriangle.down.fill")
                                    .resizable()
                                    .frame(width: triangleSize, height: triangleSize)
                                    .foregroundColor(Color.sprenPurple)
                                    .padding(.bottom, 3)
                            }
                            .frame(width: youTextWidth)
                            
                            Spacer(minLength: ((1-valuePercent)*width)-(youTextWidth/2))
                        }
                        .frame(alignment: .center)
                        
                        VStack {
                            Spacer()
                            HStack {
                                Text("1")
                                    .font(.sprenParagraph)
                                    .foregroundColor(.gray)
                                Spacer()
                                Text("100")
                                    .font(.sprenParagraph)
                                    .foregroundColor(.gray)
                            }
                            .padding([.leading, .trailing])
                        }
                    }
                    
                    ZStack {
                        // bar
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: paddedWidth, height: lineHeight)
                            .cornerRadius(lineHeight/2)
                        
                        // range
                        HStack {
                            Spacer(minLength: startPercent*width)
                            
                            Rectangle()
                                .fill(
                                    LinearGradient(gradient: Gradient(stops: [
                                        .init(color: .sprenPurple, location: 0),
                                        .init(color: .sprenPink,   location: (centerPercent-startPercent)/(endPercent-startPercent)),
                                        .init(color: .sprenPurple, location: 1),
                                    ]),
                                                   startPoint: .leading,
                                                   endPoint: .trailing)
                                )
                                .frame(height: lineHeight)
                                .cornerRadius(lineHeight/2)
                            
                            Spacer(minLength: (1-endPercent)*width)
                        }
                        
                        //center
                        HStack {
                            Spacer(minLength: (centerPercent*width)-6)
                            
                            Circle()
                                .fill(Color.sprenPurple)
                                .frame(width: lineHeight, height: lineHeight)
                            
                            Spacer(minLength: ((1-centerPercent)*width)-6)
                        }
                    }
                    
                    ZStack {
                        
                        HStack {
                            Spacer(minLength: startPercent*width-(labelWidth/2))
                            
                            Text("\(rangeStart)")
                                .font(.sprenParagraph)
                                .frame(width: labelWidth)
                            Spacer(minLength: (endPercent*width)-(startPercent*width)-labelWidth)
                            Text("\(rangeEnd)")
                                .font(.sprenParagraph)
                                .frame(width: labelWidth)
                            
                            Spacer(minLength: (1-endPercent)*(labelWidth/2))
                        }
                        
                        HStack {
                            Spacer(minLength: centerPercent*width-(labelWidth/2))
                            
                            Text("\(rangeCenter)")
                                .font(.sprenParagraph)
                                .frame(width: labelWidth)
                            
                            Spacer(minLength: (1-centerPercent)*width-(labelWidth/2))
                        }
                    
                    }
                    
                }
            }
            .frame(height: 60)
            
        }
        
    }
}

struct RangeBar_Previews: PreviewProvider {
    static var previews: some View {
        RangeBar(value: 63)
    }
}
