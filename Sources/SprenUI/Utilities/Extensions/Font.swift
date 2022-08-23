//
//  Font.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/25/22.
//

import Foundation
import SwiftUI

extension Font {
        
    static let sprenNumber = Font.custom("Sofia Pro Medium", size: Autoscale.scaleFactor*72)
    static let sprenTitle = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*30)
    static let sprenAlertTitle = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*24)
    static let sprenProgress = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*22)
    static let sprenButton = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*18)
    static let sprenParagraph = Font.custom("Sofia Pro Regular",   size: Autoscale.scaleFactor*16)
    
    static let sprenSubtitle = Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor*20)
    static let disclaimer = Font.custom("Sofia Pro Regular",   size: Autoscale.scaleFactor*9)
    
}

struct Font_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Spren Number")
                .font(.sprenNumber)
            Text("Spren Title")
                .font(.sprenTitle)
            Text("Spren Alert Title")
                .font(.sprenAlertTitle)
            Text("Spren Progress")
                .font(.sprenProgress)
            Text("Spren Button")
                .font(.sprenButton)
            Text("Spren Paragraph")
                .font(.sprenParagraph)
            
        }
        
        VStack {
            Group {
                Text("Large Title")
                    .font(.largeTitle)
                Text("Title")
                    .font(.title)
                Text("Title 2")
                    .font(.title2)
                Text("Title 3")
                    .font(.title3)
            }

            Text("Headline")
                .font(.headline)
            Text("Subheadline")
                .font(.subheadline)

            Text("Body")
                .font(.body)

            Text("Callout")
                .font(.callout)
            Text("Caption")
                .font(.caption)
            Text("Caption 2")
                .font(.caption2)
            
            Text("Footnote")
                .font(.footnote)
        }
    }
}
