//
//  MessageScreen.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

struct MessageScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let illustration: String
    let title: String
    let paragraph: String
    let buttonText: String
    
    var textVStackAlignment: HorizontalAlignment = .leading
    var titleTextAlignment: TextAlignment = .leading
    var paragraphTextAlignment: TextAlignment = .leading
    
    var onBackButtonTap: (() -> Void)? = nil
    let onBottomButtonTap: () -> Void
    
    let illustrationSize = Autoscale.scaleFactor * 300
    
    var body: some View {
        VStack {
            Header(backButtonColor: colorScheme == .light ? .black : .white, onBackButtonTap: onBackButtonTap)
                        
            if illustration == "Home" && Autoscale.scale == 3 {
                HomeAnimation()
                    .padding(Autoscale.padding)
            } else {
                Image(illustration, bundle: .module)
                    .resizable()
                    .frame(width: illustrationSize,
                           height: illustrationSize)
            }
            
            Spacer()
                
            ScrollView(showsIndicators: false) {
                VStack(alignment: textVStackAlignment, spacing: 0) {
                    Text(title)
                        .font(.sprenTitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(titleTextAlignment)
                        .padding([.leading, .trailing], Autoscale.padding)

                    Text(paragraph)
                        .font(.sprenParagraph)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(paragraphTextAlignment)
                        .padding([.top, .leading, .trailing], Autoscale.padding)
                }
            }
            
            Spacer()
            
            SprenButton(title: buttonText, action: onBottomButtonTap)
                .padding(Autoscale.padding)
        }
    }
}

struct PrereadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        
//        let previewDevices = [
            // problem devices
//            "iPhone SE (1st generation)",
//            "iPhone 6s",
//            "iPhone 7",
//            "iPhone 8",
//            "iPhone SE (2nd generation)",
//            "iPhone 11",
//            "iPhone 13 mini",
            
//            "iPhone SE (1st generation)",
//            "iPhone 6s",
//            "iPhone 6s Plus",
//            "iPhone 7",
//            "iPhone 7 Plus",
//            "iPhone 8",
//            "iPhone 8 Plus",
//            "iPhone X",
//            "iPhone XR",
//            "iPhone XS",
//            "iPhone XS Max",
//            "iPhone SE (2nd generation)",
//            "iPhone 11",
//            "iPhone 11 Pro",
//            "iPhone 11 Pro Max",
//            "iPhone 12 mini",
//            "iPhone 12",
//            "iPhone 12 Pro",
//            "iPhone 12 Pro Max",
//            "iPhone 13 mini",
//            "iPhone 13",
//            "iPhone 13 Pro",
//            "iPhone 13 Pro Max",
//        ]
        
//        ForEach(previewDevices, id: \.self) { device -> AnyView in
//            AnyView(
//                MessageScreen(illustration: "Home",
//                                 title: "Unlock advanced HRV insights with your smartphone camera",
//                                 paragraph: "•  Integrate via SDK and API\n•  Customizable look and feel\n•  Validated algorithms",
//                                 buttonText: "Do an HRV reading",
//                                 textVStackAlignment: .center,
//                                 titleTextAlignment: .center,
//                                 onBottomButtonTap: {})
//                    .previewDevice(PreviewDevice.init(rawValue: device))
//            )
//        }
        
        
        
        MessageScreen(illustration: "Home",
                      title: "Unlock advanced HRV insights with your smartphone camera",
                      paragraph: "•  Integrate via SDK and API\n•  Customizable look and feel\n•  Validated algorithms",
                      buttonText: "Try it now",
                      textVStackAlignment: .center,
                      titleTextAlignment: .center,
                      onBottomButtonTap: {})
    
        MessageScreen(illustration: "GreetingScreen1",
                         title: "Measure your HRV with your phone camera",
                         paragraph: "Simply do a quick resting scan when you wake up to receive personalized stress and recovery insights.",
                         buttonText: "Next",
                      onBackButtonTap: {},
                      onBottomButtonTap: {})
    
        MessageScreen(illustration: "GreetingScreen2",
                      title: "Place your fingertip on the rear-facing camera",
                      paragraph: "For the most accurate reading, leave the flash on or make sure you're in a well lit area and can hold your hand steady.",
                      buttonText: "Next",
                      onBackButtonTap: {},
                      onBottomButtonTap: {})
    
        MessageScreen(illustration: "NoCamera",
                      title: "Camera access is needed to start an HRV measurement",
                      paragraph: "Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.",
                      buttonText: "Enable camera",
                      onBackButtonTap: {},
                      onBottomButtonTap: {})
    
        MessageScreen(illustration: "FingerOnCamera",
                      title: "Place your fingertip fully over the camera lens",
                      paragraph: "Hold your hand steady and apply light pressure with your finger.",
                      buttonText: "Start measurement",
                      onBackButtonTap: {},
                      onBottomButtonTap: {})
        
        MessageScreen(illustration: "Server",
                      title: "Sorry! There was an error calculating your results",
                      paragraph: "Please take another measurement to view your HRV results.",
                      buttonText: "Try again",
                      onBackButtonTap: {},
                      onBottomButtonTap: {})
        
    }
}
