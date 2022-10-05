//
//  FitnessLevelInput.swift
//  SprenInternal
//
//  Created by nick on 20.08.2022.
//

import SwiftUI

struct FitnessLevelInput: View {

    @Binding var isPickerVisible: Bool
    @Binding var fitnessLevel: Int
    var strokeColor: Color = Color("AppPink", bundle: .module)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("\(fitnessLevel)")
                    .font(Font.custom("Sofia Pro Regular", size: 21))
                Spacer()
                Text("days in week")
                    .font(Font.custom("Sofia Pro Regular", size: 21))
                    .foregroundColor(Color("AppPink", bundle: .module))
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(strokeColor, style: StrokeStyle(lineWidth: 1.0)))
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation {
                    isPickerVisible.toggle()
                }
            }
        }
    }
}
