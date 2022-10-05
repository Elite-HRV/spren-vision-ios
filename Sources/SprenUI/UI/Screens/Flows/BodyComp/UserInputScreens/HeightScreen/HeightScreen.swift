//
//  HeightScreen.swift
//  SprenInternal
//
//  Created by nick on 29.07.2022.
//

import SwiftUI

let FEETS = Array(0..<8)
let INCHES = Array(0..<12)
let CENTIMETERS = Array(0..<251)

struct HeightScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = ViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: Autoscale.convert(20)) {
            HStack(spacing: Autoscale.convert(15)) {
                ForEach(0..<2) {_ in
                    Rectangle()
                        .frame(height: Autoscale.convert(4))
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(Color("AppPink", bundle: .module))
                }
                ForEach(0..<3) {_ in
                    Rectangle()
                        .frame(height:Autoscale.convert(4), alignment: .bottom)
                        .cornerRadius(Autoscale.convert(2))
                        .foregroundColor(Color("AppPink", bundle: .module).opacity(0.3))
                }
            }
            CloseButton(action : {
                self.presentationMode.wrappedValue.dismiss()
            })
            Text("Enter your height")
                .font(Font.custom("Sofia Pro Semi Bold", size: 40))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
            Text("We need to know your height to provide you with accurate measurement results.")
                .font(Font.custom("Sofia Pro Regular", size: 21))
                .lineLimit(2)
                .minimumScaleFactor(0.01)

            HeightInput(isPickerVisible: $viewModel.isPickerVisible, selection: $viewModel.selection)
            Spacer()
            NavigationLink(destination: AgeScreen()) {
                PurpleButton(text: "Next")
            }.simultaneousGesture(TapGesture().onEnded {
                UserData.default.saveHeight(viewModel.selection)
            })
            HeightInputPicker(isPickerVisible: $viewModel.isPickerVisible, selection: $viewModel.selection)
        }
        .navigationBarHidden(true)
        .padding(.all, Autoscale.convert(15))
    }
}

extension HeightScreen {
    final class ViewModel: ObservableObject {
        @Published var selection = UserData.getHeight()
        @Published var isPickerVisible = false
    }
}

struct HeightScreen_Previews: PreviewProvider {
    static var previews: some View {
        HeightScreen()
    }
}
