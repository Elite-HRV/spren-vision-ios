//
//  MeasurementProgress.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/27/22.
//

import SwiftUI

struct MeasurementProgress: View {
    
    let progress: Int
    let text: String
    
    let size = Autoscale.scaleFactor * 60
    let lineWidth = Autoscale.scaleFactor * 6
    let cornerRadius = Autoscale.scaleFactor * 16
    
    let checkWidth  = Autoscale.scaleFactor * 30
    
    var body: some View {
        HStack {
            ZStack {
                if progress == 100 {
                    Image("Checkmark", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: checkWidth)
                } else {
                    Text("\(progress)%")
                        .font(.sprenProgress)
                }
                Circle()
                    .stroke(lineWidth: lineWidth)
                    .opacity(0.2)
                    .foregroundColor(Color.gray)
                    .frame(width: size, height: size)
                Circle()
                    .trim(from: 0.0, to: CGFloat(progress)/100)
                    .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                    .rotationEffect(Angle(degrees: 270.0))
                    .foregroundColor(Color.green)
                    .frame(width: size, height: size)
                
            }
            .padding([.leading, .trailing], Autoscale.padding)
            Spacer()
            Text(text)
                .font(.sprenParagraph)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .frame(height: size)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .bottom, .trailing], Autoscale.padding)
        }
        .frame(maxWidth: .infinity)
        .padding(Autoscale.padding)
        .background(Color.white)
        .cornerRadius(cornerRadius)
    }
}

struct MeasurementProgress_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                MeasurementProgress(progress: 0, text: "Place your fingertip over the rear-facing camera lens.")
                    .padding()
                
                MeasurementProgress(progress: 0, text: "Almost there...")
                    .padding()
            }
        }
        
        ZStack {
            Color.black.ignoresSafeArea()
            MeasurementProgress(progress: 30, text: "Place your fingertip over the rear-facing camera lens.")
                .padding()
        }
        
        ZStack {
            Color.black.ignoresSafeArea()
            MeasurementProgress(progress: 100, text: "Place your fingertip over the rear-facing camera lens.")
                .padding()
        }
    }
}
