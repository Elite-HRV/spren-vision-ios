//
//  Font.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/25/22.
//

import Foundation
import SwiftUI

extension Font {
        
//    static let sprenNumber = Font.custom("Sofia Pro Medium", size: Autoscale.scaleFactor*72)
//    static let sprenTitle = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*30)
//    static let sprenAlertTitle = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*24)
//    static let sprenProgress = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*22)
//    static let sprenButton = Font.custom("Sofia Pro Semi Bold", size: Autoscale.scaleFactor*18)
//    static let sprenParagraph = Font.custom("Sofia Pro Regular",   size: Autoscale.scaleFactor*16)
//
//    static let sprenSubtitle = Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor*20)
//    static let disclaimer = Font.custom("Sofia Pro Regular",   size: Autoscale.scaleFactor*9)
    
    static let sprenNumber = Font.custom("Avenir Next", size: Autoscale.scaleFactor*50)
    static let sprenTitle = Font.custom("Avenir Next Demi Bold", size: Autoscale.scaleFactor*30)
    static let sprenAlertTitle = Font.custom("Avenir Next Demi Bold", size: Autoscale.scaleFactor*24)
    static let sprenProgress = Font.custom("Avenir Next Demi Bold", size: Autoscale.scaleFactor*20)
    static let sprenButton = Font.custom("Avenir Next Demi Bold", size: Autoscale.scaleFactor*18)
    static let sprenParagraph = Font.custom("Avenir Next Medium",   size: Autoscale.scaleFactor*16)

    static let sprenSubtitle = Font.custom("Avenir Next Medium", size: Autoscale.scaleFactor*20)
    static let disclaimer = Font.custom("Avenir Next",   size: Autoscale.scaleFactor*9)
    
    static let sprenLabel = Font.custom("Avenir Next Medium", size: Autoscale.scaleFactor*14)
    static let sprenLabelBold = Font.custom("Avenir Next Demi Bold", size: Autoscale.scaleFactor*14)
    static let sprenLabelSmallBold = Font.custom("Avenir Next Demi Bold", size: Autoscale.scaleFactor*12)
    static let sprenLabelSmall = Font.custom("Avenir Next Medium", size: Autoscale.scaleFactor*12)
}

//public enum CustomFonts {
//    public static func registerCustomFonts() {
//        for font in ["Roboto-Light.ttf", "Roboto-Medium.ttf", "Roboto-Regular.ttf"] {
//            guard let url = Bundle.module.url(forResource: font, withExtension: nil) else { return }
//            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
//        }
//    }
//}
//
//extension View {
//    public func loadCustomFonts() -> some View {
//        CustomFonts.registerCustomFonts()
//        return self
//    }
//}

struct Font_Previews: PreviewProvider {
    static var previews: some View {
//        AnyView(VStack {
//            Text("Spren Number")
//                .font(.sprenNumber)
//            Text("Spren Title")
//                .font(.sprenTitle)
//            Text("Spren Alert Title")
//                .font(.sprenAlertTitle)
//            Text("Spren Progress")
//                .font(.sprenProgress)
//            Text("Spren Button")
//                .font(.sprenButton)
//            Text("Spren Paragraph")
//                .font(.sprenParagraph)
//            Text("Spren Subtitle")
//                .font(.sprenSubtitle)
//            Text("Spren Disclaimer")
//                .font(.disclaimer)
//        })
//        .loadCustomFonts()
        
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
            Text("Spren Subtitle")
                .font(.sprenSubtitle)
            Text("Spren Disclaimer")
                .font(.disclaimer)
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
