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
    var strokeColor: Color = .sprenUISecondaryColor
    
    var body: some View {
        let binding = Binding<Int?>(get: {
            return self.age
        }, set: {
            if let age = $0 {
                self.age = age
            }else{
                self.age = 0
            }
        })
        
        TextField("Enter your age", value: binding, formatter: numberFormatter)
            .font(.sprenInput)
            .keyboardType(.numberPad)
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 8).strokeBorder(strokeColor, style: StrokeStyle(lineWidth: 1.0)))
    }
}
