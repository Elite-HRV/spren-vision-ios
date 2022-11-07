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
    var strokeColor: Color = .sprenUISecondaryColor
    
    var body: some View {
        
        let binding = Binding<Double?>(get: {
            return self.weight
        }, set: {
            if let weight = $0 {
                self.weight = weight
            }else{
                self.weight = 0
            }
        })
        
        VStack(alignment: .leading, spacing: 0) {
            let textUnit = weightMetric == 0 ? "lbs" : "kg"
            HStack {
                TextField("Enter your weight", value: binding, formatter: numberFormatter)
                    .font(.sprenInput)
                    .keyboardType(.decimalPad)
                Spacer()
                Text(textUnit)
                    .font(.sprenInput)
                    .foregroundColor(.sprenUISecondaryColor)
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(strokeColor, style: StrokeStyle(lineWidth: 1.0)))
        }
    }
}
