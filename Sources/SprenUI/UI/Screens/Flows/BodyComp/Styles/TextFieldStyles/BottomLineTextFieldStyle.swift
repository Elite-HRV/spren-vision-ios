//
//  BottomLineTextFieldStyle.swift
//  SprenInternal
//
//  Created by nick on 29.07.2022.
//

import SwiftUI

struct BottomLineTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 0) {
            configuration.padding(.vertical, 11)
            Rectangle()
                .frame(height: 1, alignment: .bottom)
                .foregroundColor(.sprenUISecondaryColor)
        }
    }
}
