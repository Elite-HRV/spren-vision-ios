//
//  Hint.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI

struct Hint: View {
    
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "checkmark.circle.fill").foregroundColor(Color.sprenUIColor1)
            Text(text)
                .font(.sprenParagraph)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }
}

struct Hint_Previews: PreviewProvider {
    static var previews: some View {
        Hint(text: "test")
    }
}
