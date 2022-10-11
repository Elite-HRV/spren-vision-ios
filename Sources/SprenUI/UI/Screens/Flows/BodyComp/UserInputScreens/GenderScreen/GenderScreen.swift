//
//  GenderScreen.swift
//  SprenInternal
//
//  Created by nick on 16.08.2022.
//

import SwiftUI

struct GenderScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    @State private var biologicalSex = UserData.default.biologicalSex

    var body: some View {
        VStack(alignment: .leading, spacing: Autoscale.convert(20)) {
            HStack(spacing:Autoscale.convert(15)) {
                ForEach(0..<4) {_ in
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(Color.sprenUIColor1)
                }
                ForEach(0..<1) {_ in
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(Color.sprenUIColor1.opacity(0.3))
                }
            }
            CloseButton(action : {
                self.presentationMode.wrappedValue.dismiss()
            })
            Text("Select your gender")
                .font(.sprenBoldNumber)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
            Text("This data improve the accuracy of the results and used to provide appropriate reference ranges and guidance.")
                .font(.sprenInput)
                .lineLimit(3)
                .minimumScaleFactor(0.01)

            VStack(alignment: .leading, spacing: 0) {
                Text("Gender")
                    .font(.sprenInput)
                    .padding([.bottom], 10)
                GenderInput(biologicalSex: $biologicalSex)
            }

            Spacer()
            NavigationLink(destination: FitnessLevelScreen()) {
                PurpleButton(text: "Next")
            }.simultaneousGesture(TapGesture().onEnded {
                UserData.default.saveBiologicalSex(self.$biologicalSex.wrappedValue)
            })
        }
        .navigationBarHidden(true)
        .padding(.all, Autoscale.convert(15))
    }
}

struct GenderScreen_Previews: PreviewProvider {
    static var previews: some View {
        GenderScreen()
    }
}
