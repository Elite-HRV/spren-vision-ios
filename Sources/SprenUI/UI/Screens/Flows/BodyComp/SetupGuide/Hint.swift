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

struct Hint_Previews: PreviewProvider {
    static var previews: some View {
        Hint(text: "test")
    }
}
