//
//  BackButton.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

struct BackButton: View {
    
    var color: Color
    var action: (() -> Void)? = nil

    var body: some View {
        Button(action: action ?? {}) {
            Image(systemName: "xmark")
                .resizable()
                .frame(width: 25*Autoscale.scaleFactor,
                       height: 25*Autoscale.scaleFactor)
        }
        .padding(Autoscale.padding)
        .foregroundColor(color)
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton(color: .black, action: {})
    }
}
