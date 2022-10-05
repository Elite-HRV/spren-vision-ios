//
//  FitnessLevelInputPicker.swift
//  SprenInternal
//
//  Created by nick on 20.08.2022.
//

import SwiftUI

struct FitnessLevelInputPicker: View {

    @Binding var isPickerVisible: Bool
    @Binding var fitnessLevel: Int

    var body: some View {
        if isPickerVisible {
            Picker("", selection: $fitnessLevel) {
                ForEach(0..<8) {index in
                    Text("\(index)").tag(index)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
