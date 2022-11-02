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
    var strokeColor: Color = .sprenUISecondaryColor
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("\(fitnessLevel)")
                    .font(.sprenInput)
                Spacer()
                Text("days in week")
                    .font(.sprenInput)
                    .foregroundColor(.sprenUISecondaryColor)
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
