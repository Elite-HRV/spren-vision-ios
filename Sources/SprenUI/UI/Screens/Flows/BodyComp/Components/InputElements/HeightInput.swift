//
//  HeightInput.swift
//  SprenInternal
//
//  Created by nick on 19.08.2022.
//

import SwiftUI

struct HeightInput: View {

    @Binding var isPickerVisible: Bool
    @Binding var selection: HeightSize
    var strokeColor: Color = Color("AppPink", bundle: .module)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let text = selection.unit == HeightSize.Unit.ft_in
                ? "\(selection.feet)’ \(selection.inches)’’"
                : "\(selection.centimeters) cm"
            let textUnit = selection.unit == HeightSize.Unit.ft_in ? "ft/in" : "cm"
            HStack {
                Text(text)
                    .font(Font.custom("Sofia Pro Regular", size: 21))
                Spacer()
                Text(textUnit)
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
