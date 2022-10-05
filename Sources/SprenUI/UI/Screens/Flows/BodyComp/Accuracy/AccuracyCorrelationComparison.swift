//
//  AccuracyCorrelationComparison.swift
//  SprenInternal
//
//  Created by Fernando on 8/12/22.
//

import SwiftUI

struct AccuracyCorrelationComparison: View {
    var body: some View {
        VStack {
            ZStack {
                Color(.white)
                VStack {
                    HStack {
                        Text("Correlation Comparison")
                            .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 20))
                            .lineLimit(1)
                            .minimumScaleFactor(0.01)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, Autoscale.convert(16))
                                                
                        Spacer()
                    }
                    
                    Image("AccuracyCorrelationComparison").resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    HStack {
                        Text("This chart shows a high degree of correlation between the body volume (BV) estimates of the Underwater weighing method (UWW) and our 2D image processing system (SPREN) for calculating body composition results.")
                            .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 14))
                            .multilineTextAlignment(.leading)
                            .lineSpacing(3)
                            .padding(.top, 16)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }.padding(16)
            }
        }.cornerRadius(16)
    }
}

struct AccuracyCorrelationComparison_Previews: PreviewProvider {
    static var previews: some View {
        AccuracyCorrelationComparison()
    }
}
