//
//  WeightScreen.swift
//  SprenInternal
//
//  Created by nick on 28.07.2022.
//

import SwiftUI

struct WeightScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var weight = UserData.default.weight
    @State private var weightMetric = UserData.default.weightMetric

    var body: some View {
        VStack(alignment: .leading, spacing: Autoscale.convert(20)) {
            HStack(spacing:Autoscale.convert(15)) {
                Rectangle()
                    .frame(height:Autoscale.convert(4), alignment: .bottom)
                    .cornerRadius(Autoscale.convert(2))
                    .foregroundColor(Color.sprenUIColor1)
                ForEach(0..<4) {_ in 
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(Color.sprenUIColor1.opacity(0.3))
                }
            }
            CloseButton(action : {
                self.presentationMode.wrappedValue.dismiss()
            })
            Text("Enter your weight")
                .font(.sprenBoldNumber)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
            Text("We need your body weight to accurately track changes in fat-free mass and fat mass over time.")
                .font(.sprenInput)
                .lineLimit(3)
                .minimumScaleFactor(0.01)

            Picker("", selection: $weightMetric) {
                Text("lbs").tag(0)
                Text("kg").tag(1)
            }
            .pickerStyle(.segmented)
            WeightInput(weight: $weight, weightMetric: weightMetric)
            Spacer()
            NavigationLink(destination: HeightScreen()) {
                PurpleButton(text: "Next")
            }.simultaneousGesture(TapGesture().onEnded{
                UserData.default.saveWeight(self.$weight.wrappedValue, self.$weightMetric.wrappedValue)
            })
        }
        .navigationBarHidden(true)
        .padding(.all, Autoscale.convert(15))
    }
}

struct WeightScreen_Previews: PreviewProvider {
    static var previews: some View {
        WeightScreen()
    }
}
