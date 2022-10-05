//
//  PurpleButton.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI

struct PurpleButton: View {
    
    var text: String

    var body: some View {
        Text(text)
            .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 18))
            .lineLimit(1)
            .minimumScaleFactor(0.01)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: Autoscale.convert(50))
            .background(Color("AppPurple", bundle: .module))
            .cornerRadius(Autoscale.convert(6))
    }
}
