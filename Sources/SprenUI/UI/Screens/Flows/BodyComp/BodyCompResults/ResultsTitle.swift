//
//  Title.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 28/07/22.
//

import SwiftUI

struct ResultsTitle: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: String
    var lines: Int
    
    var body: some View {
        Text(text)
        .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
        .font(.sprenAlertTitle)
        .lineLimit(lines)        
        .minimumScaleFactor(0.01)
        .multilineTextAlignment(.center)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        ResultsTitle(text: "Your Body Composition Analysis", lines: 1)
    }
}
