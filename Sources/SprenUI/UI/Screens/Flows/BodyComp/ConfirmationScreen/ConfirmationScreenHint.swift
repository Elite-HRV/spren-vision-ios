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
            Image(systemName: "checkmark.circle.fill").foregroundColor(Color.sprenUISecondaryColor)
            Text(text)
                .font(.sprenParagraph)
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
