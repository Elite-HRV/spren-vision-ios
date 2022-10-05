//
//  FitnessLevelScreen.swift
//  SprenInternal
//
//  Created by nick on 16.08.2022.
//

import SwiftUI

struct FitnessLevelScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var fitnessLevel = UserData.default.fitnessLevel
    @State private var isPickerVisible = false

    var body: some View {
        VStack(alignment: .leading, spacing: Autoscale.convert(20)) {
            HStack(spacing:Autoscale.convert(15)) {
                ForEach(0..<5) {_ in
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(Color("AppPink"))
                }
            }
            CloseButton(action : {
                self.presentationMode.wrappedValue.dismiss()
            })
            Text("Recent activity level")
                .font(Font.custom("Sofia Pro Semi Bold", size: 40))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
            Text("During the last 7 days, on how many days did you do vigorous physical activities like heavy lifting or hard cardio exercise?")
                .font(Font.custom("Sofia Pro Regular", size: 21))
                .lineLimit(3)
                .minimumScaleFactor(0.01)

            FitnessLevelInput(isPickerVisible: $isPickerVisible, fitnessLevel: $fitnessLevel)
            Spacer()
            NavigationLink(destination: SetupGuide()) {
                PurpleButton(text: "Next")
            }.simultaneousGesture(TapGesture().onEnded {
                UserData.default.saveFitnessLevel(self.$fitnessLevel.wrappedValue)
            })
            FitnessLevelInputPicker(isPickerVisible: $isPickerVisible, fitnessLevel: $fitnessLevel)
        }
        .navigationBarHidden(true)
        .padding(.all, Autoscale.convert(15))
    }
}
