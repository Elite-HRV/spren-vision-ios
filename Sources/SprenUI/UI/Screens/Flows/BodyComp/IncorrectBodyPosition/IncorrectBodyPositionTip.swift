//
//  IncorrectBodyPositionTip.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 29/07/22.
//

import SwiftUI

struct IncorrectBodyPositionTip: View {
    
    var text: String
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "checkmark.circle.fill").foregroundColor(Color("AppPink", bundle: .module))
            Text(text)
                .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
                .lineLimit(2)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)

            Spacer()
        }
    }
}

struct IncorrectBodyPositionTip_Previews: PreviewProvider {
    static var previews: some View {
        IncorrectBodyPositionTip(text: "Put your arms out around 45 degrees from your body ")
    }
}
