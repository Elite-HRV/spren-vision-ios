//
//  HeightInputPicker.swift
//  SprenInternal
//
//  Created by nick on 19.08.2022.
//

import SwiftUI

struct HeightInputPicker: View {

    @Binding var isPickerVisible: Bool
    @Binding var selection: HeightSize
    
    var body: some View {
        let screenSize: CGRect = UIScreen.main.bounds

        if isPickerVisible {
            VStack {
                HStack {
                    Spacer()
                    Button {
                        isPickerVisible.toggle()
                    } label: {
                        Text("Done")
                            .font(.sprenParagraphBold).fontWeight(.bold)
                            .foregroundColor(Color("AppPink", bundle: .module))
                    }
                }
                HStack {
                    HeightPicker(selection: $selection, feet: FEETS, inches: INCHES, units: HeightSize.Unit.allCases, centimeters: CENTIMETERS)
                        .frame(width: screenSize.width - Autoscale.convert(2 * 15) , height: 200, alignment: .center)
                }
            }
        }
    }
}

