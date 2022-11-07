//
//  AgeScreen.swift
//  SprenInternal
//
//  Created by nick on 16.08.2022.
//

import SwiftUI

struct AgeScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    @State private var age = UserData.default.age
    
    var body: some View {
        VStack(alignment: .leading, spacing: Autoscale.convert(20)) {
            HStack(spacing:Autoscale.convert(15)) {
                ForEach(0..<3) {_ in
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(.sprenUISecondaryColor)
                }
                ForEach(0..<2) {_ in
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(.sprenUISecondaryColor.opacity(0.3))
                }
            }
            CloseButton(action : {
                self.presentationMode.wrappedValue.dismiss()
            })
            Text("Enter your age")
                .font(.sprenBoldNumber)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
            Text("This data improve the accuracy of the results and used to provide appropriate reference ranges and guidance.")
                .font(.sprenInput)
                .lineLimit(3)
                .minimumScaleFactor(0.01)

            VStack(alignment: .leading, spacing: 0) {
                Text("Age")
                    .font(.sprenInput)
                    .padding([.bottom], 10)
                AgeInput(age: $age)
            }

            Spacer()
            
            if(age == 0){
                PurpleButton(text: "Next")
            }else{
                NavigationLink(destination: GenderScreen()) {
                    PurpleButton(text: "Next")
                }.simultaneousGesture(TapGesture().onEnded {
                    UserData.default.saveAge(self.$age.wrappedValue)
                })
            }
        }
        .navigationBarHidden(true)
        .padding(.all, Autoscale.convert(15))
    }
}

struct AgeScreen_Previews: PreviewProvider {
    static var previews: some View {
        AgeScreen()
    }
}
