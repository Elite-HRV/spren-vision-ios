//
//  MessageScreen.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

public struct MessageScreen: View {

    @Environment(\.colorScheme) var colorScheme
    
    let illustration: String
    let title: String
    let paragraph: String?
    let bulletsLabel: String
    let bullets: [String]
    let buttonText: String
    
    var textVStackAlignment: HorizontalAlignment = .leading
    var titleTextAlignment: TextAlignment = .leading
    var paragraphTextAlignment: TextAlignment = .leading
    
    var onBackButtonTap: (() -> Void)? = nil
    let onBottomButtonTap: () -> Void
    
    let illustrationSize = Autoscale.scaleFactor * 300
    
    public init(illustration: String,
                title: String,
                paragraph: String? = nil,
                bulletsLabel: String = "",
                bullets: [String] = [],
                buttonText: String,
                textVStackAlignment: HorizontalAlignment = .leading,
                titleTextAlignment: TextAlignment = .leading,
                paragraphTextAlignment: TextAlignment = .leading,
                onBackButtonTap: (() -> Void)? = nil,
                onBottomButtonTap: @escaping () -> Void) {
        self.illustration = illustration
        self.title = title
        self.paragraph = paragraph
        self.bulletsLabel = bulletsLabel
        self.bullets = bullets
        self.buttonText = buttonText
        self.textVStackAlignment = textVStackAlignment
        self.titleTextAlignment = titleTextAlignment
        self.paragraphTextAlignment = paragraphTextAlignment
        self.onBackButtonTap = onBackButtonTap
        self.onBottomButtonTap = onBottomButtonTap
    }
    
    public var body: some View {
        VStack {
            Header(backButtonColor: colorScheme == .light ? .black : .white, onBackButtonTap: onBackButtonTap)
            
            // demo app
            if illustration == "Home" && Autoscale.scale == 3 {
                HomeAnimation()
                    .sprenUIPadding()
            } else if illustration == "Home" {
                Image("Home", bundle: .module)
                    .resizable()
                    .frame(width: illustrationSize,
                           height: illustrationSize)
            }
            
            // SprenUI
            else {
                if SprenUI.config.bundle == .module {
                    Image(illustration, bundle: SprenUI.config.bundle)
                        .resizable()
                        .frame(width: illustrationSize,
                               height: illustrationSize)
                        .colorMultiply(Color.sprenUIColor1.opacity(0.75))
                } else {
                    Image(illustration, bundle: SprenUI.config.bundle)
                        .resizable()
                        .frame(width: illustrationSize,
                               height: illustrationSize)
                }
            }
            
            Spacer()
                
            ScrollView(showsIndicators: false) {
                VStack(alignment: textVStackAlignment, spacing: 0) {
                    Text(title)
                        .font(.sprenTitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(titleTextAlignment)
                        .sprenUIPadding([.leading, .trailing])
                    
                    if let paragraph = paragraph {
                        Text(paragraph)
                            .font(.sprenParagraph)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(paragraphTextAlignment)
                            .sprenUIPadding([.top, .leading, .trailing])
                    }
                    
                    if bullets.count > 0 {
                        Text(bulletsLabel)
                            .font(.sprenParagraph)
                            .sprenUIPadding([.top], factor: 0.75)
                            .sprenUIPadding([.bottom], factor: 0.25)
                            .sprenUIPadding([.leading, .trailing])
                        
                        ForEach(bullets, id: \.self) { bullet in
                            HStack {
                                VStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.sprenUIColor1)
                                    Spacer()
                                }
                                Text(bullet)
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.sprenBullet)
                            }
                            .sprenUIPadding([.leading, .trailing])
                        }
                    }
                }
            }
            
            Spacer()
            
            SprenButton(title: buttonText, action: onBottomButtonTap)
                .sprenUIPadding()
        }
    }
}


struct MessageScreen_Previews: PreviewProvider {
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
                      title: "Measure your HRV and Recovery with your phone camera",
                      paragraph: "Simply do a quick resting scan to receive personalized stress and recovery insights.",
                      bulletsLabel: "For best HRV and recovery results:",
                      bullets: [
                        "Refrain from strenuous activity for at least 15 minutes prior to reading",
                        "Sit calmly for 1 minute before reading"
                      ],
                      buttonText: "Next",
                      onBackButtonTap: {},
                      onBottomButtonTap: {})
        
        MessageScreen(illustration: "GreetingScreen1",
                      title: "Take a moment to measure your recovery",
                      bulletsLabel: "For best HRV and recovery results:",
                      bullets: [
                        "Refrain from strenuous activity for at least 15 minutes prior to reading",
                        "Sit calmly for 1 minute before reading",
                        "If needed, take 6 deep and slow breaths before starting reading then breathe naturally during the reading"
                      ],
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
