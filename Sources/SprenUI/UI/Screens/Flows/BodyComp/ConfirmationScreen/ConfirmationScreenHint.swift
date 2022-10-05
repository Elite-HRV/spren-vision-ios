//
//  ConfirmationHint.swift
//  SprenInternal
//
//  Created by Fernando on 8/22/22.
//

import SwiftUI

struct ConfirmationScreenHint: View {
    
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill").foregroundColor(Color("AppPink", bundle: .module))
            Text(text)
                .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }
}

struct ConfirmationHint_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationScreenHint(text: "test")
    }
}
