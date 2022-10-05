//
//  Title.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 28/07/22.
//

import SwiftUI

struct ResultsTitle: View {
    
    var text: String
    var lines: Int
    
    var body: some View {
        Text(text)
        .foregroundColor(Color("AppBlack"))
        .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 24))
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
