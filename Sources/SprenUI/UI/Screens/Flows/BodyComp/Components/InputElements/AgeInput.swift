//
//  AgeInput.swift
//  SprenInternal
//
//  Created by nick on 20.08.2022.
//

import SwiftUI

struct AgeInput: View {

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        return formatter
    }()

    @Binding var age: Int
    var strokeColor: Color = Color.sprenUIColor1
    
    var body: some View {
        TextField("Enter your age", value: $age, formatter: numberFormatter)
            .font(.sprenInput)
            .keyboardType(.numberPad)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(strokeColor, style: StrokeStyle(lineWidth: 1.0)))
    }
}
