//
//  GenderInput.swift
//  SprenInternal
//
//  Created by nick on 20.08.2022.
//

import SwiftUI

struct GenderInput: View {

    @Binding var biologicalSex: Int
    
    var body: some View {
        Picker("", selection: $biologicalSex) {
            Text("Male").tag(0)
            Text("Female").tag(1)
            Text("Other").tag(2)
        }
        .pickerStyle(.segmented)
    }
}
