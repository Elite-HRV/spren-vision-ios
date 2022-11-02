//
//  WeightInput.swift
//  SprenInternal
//
//  Created by nick on 19.08.2022.
//

import SwiftUI

struct WeightInput: View {

    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    @Binding var weight: Double
    var weightMetric: Int
    var strokeColor: Color = Color.sprenUIColor1
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let textUnit = weightMetric == 0 ? "lbs" : "kg"
            HStack {
                TextField("Enter your weight", value: $weight, formatter: numberFormatter)
                    .font(.sprenInput)
                    .keyboardType(.decimalPad)
                Spacer()
                Text(textUnit)
                    .font(.sprenInput)
                    .foregroundColor(Color.sprenUIColor1)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(strokeColor, style: StrokeStyle(lineWidth: 1.0)))
        }
    }
}
