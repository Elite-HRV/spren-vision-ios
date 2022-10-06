//
//  Accuracy.swift
//  SprenInternal
//
//  Created by Fernando on 8/12/22.
//

import SwiftUI

struct Accuracy: View {
    
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            
            Color("AppBackground", bundle: .module).edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    CloseButton(action: {self.presentationMode.wrappedValue.dismiss()})
                    
                    title
                    
                    text1
                    
                    AccuracyCorrelationComparison()
                    
                    text2
                    
                    title2
                    
                    text3
                    
                    disclaimer
                }.padding(.horizontal, Autoscale.convert(16)).padding(.top, 0.1)
            }                
        }.navigationBarHidden(true)
    }
    
    var title: some View {
        HStack {
            Text("How accurate is this?")
                .font(.sprenTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
                .padding(.bottom, Autoscale.convert(16))
            Spacer()
        }
    }
    
    var text1: some View {
        HStack {
            Text("Spren Body Composition is powered by a computer vision algorithm that delivers body composition results that are 96-99% comparable to gold-standard laboratory measurement methods such as DEXA and Underwater Weighing - but from the comfort of your own home.\n\nFour independent research groups published studies verifying the accuracy of our patented Body Composition imaging technology.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading).padding(.bottom, Autoscale.convert(20))
            Spacer()
        }
    }
    
    var text2: some View {
        HStack {
            Text("Now you can get a comprehensive set of body composition insights including body fat percentage, lean mass, hip and waist fat, ratios, and a Body Health score all from a convenient selfie.\n\nOther common body composition methods such as DEXA, underwater weighing, and Bio-impedance 3D scans are expensive specialty screenings that require a trip to a facility with a trained professional and an invasive protocol. At-home bio-impedance scales have low accuracy and consistency and fail to provide important fat distribution information.\n\nSpren’s Body Composition technology allows you to better track your fitness and health progress accurately and conveniently.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading).padding(.top, Autoscale.convert(20)).padding(.bottom, Autoscale.convert(20))
            Spacer()
        }
    }
    
    var title2: some View {
        HStack {
            Text("Why body composition instead of weight and BMI?")
                .font(.sprenTitle)
                .lineLimit(3)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
                .padding(.bottom, Autoscale.convert(5))
            Spacer()
        }
    }
    
    var text3: some View {
        HStack {
            Text("Weight and BMI do not consider body type or distinguish fat from muscle and therefore can easily misclassify a person and their health risks. For example, an athlete can be overweight according to BMI but in reality they are not overfat and have higher muscle mass for their height and demographic.\n\nBody composition metrics such as body fat percentage, lean mass, and information about fat distribution can provide a more accurate picture of your health and fitness.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading).padding(.bottom, Autoscale.convert(20))
            Spacer()
        }
    }
    
    var disclaimer: some View {
        HStack {
            Group {
                Text("Disclaimer:").bold() +
                Text(" This body composition scan is not intended for pregnant women or women up to 6 months post-partum. The results would not reflect accurate body composition for pregnant and post-partum women and following the body composition results and insights could be harmful to the fetus or mother.")
            }.font(.sprenLabel)
                .foregroundColor(Color("AppGrey", bundle: .module))
            .multilineTextAlignment(.leading)
            Spacer()
        }.padding(.top, Autoscale.convert(50)).padding(.bottom, Autoscale.convert(20))
    }
}

struct Accuracy_Previews: PreviewProvider {
    static var previews: some View {
        Accuracy()
    }
}
