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
        HStack(alignment: .top) {
            Image(systemName: "checkmark.circle.fill").foregroundColor(Color.sprenUISecondaryColor)
            Text(text)
                .font(.sprenParagraph)
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
