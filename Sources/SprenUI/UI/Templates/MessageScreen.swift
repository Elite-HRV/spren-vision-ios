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
    let paragraph: String
    let buttonText: String
    
    var textVStackAlignment: HorizontalAlignment = .leading
    var titleTextAlignment: TextAlignment = .leading
    var paragraphTextAlignment: TextAlignment = .leading
    
    var onBackButtonTap: (() -> Void)? = nil
    let onBottomButtonTap: () -> Void
    
    let illustrationSize = Autoscale.scaleFactor * 300
    
    public init(illustration: String, title: String, paragraph: String, buttonText: String, textVStackAlignment: HorizontalAlignment = .leading, titleTextAlignment: TextAlignment = .leading, paragraphTextAlignment: TextAlignment = .leading, onBackButtonTap: (() -> Void)? = nil, onBottomButtonTap: @escaping () -> Void) {
        self.illustration = illustration
        self.title = title
        self.paragraph = paragraph
        self.buttonText = buttonText
        self.textVStackAlignment = textVStackAlignment
        self.titleTextAlignment = titleTextAlignment
        self.paragraphTextAlignment = paragraphTextAlignment
        self.onBackButtonTap = onBackButtonTap
        self.onBottomButtonTap = onBottomButtonTap
    }
    
    private let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    @State private var birthdate: Date?
    var genders = ["none", "male", "female"]
    @State private var gender: String = "none"
    
    public var body: some View {
        VStack {
            Header(backButtonColor: colorScheme == .light ? .black : .white, onBackButtonTap: onBackButtonTap)
                        
            if illustration == "Home" && Autoscale.scale == 3 {
                HomeAnimation()
                    .sprenUIPadding()
            } else {
                Image(illustration, bundle: .module)
                    .resizable()
                    .frame(width: illustrationSize,
                           height: illustrationSize)
                    .colorMultiply(Color.sprenUIColor.opacity(0.75))
            }
            
            Spacer()
                
            ScrollView(showsIndicators: false) {
                VStack(alignment: textVStackAlignment, spacing: 0) {
                    Text(title)
                        .font(.sprenTitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(titleTextAlignment)
                        .sprenUIPadding([.leading, .trailing])

                    Text(paragraph)
                        .font(.sprenParagraph)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(paragraphTextAlignment)
                        .sprenUIPadding([.top, .leading, .trailing])
                }
            }
            
            if(illustration == "GreetingScreen1"){
                HStack{
                    if(birthdate == nil){
                        Button{
                            birthdate = Date()
                        } label:{
                            Text("Set the birthdate").font(.sprenLabel)
                        }
                    }else{
                        DatePicker("Birthdate:", selection: $birthdate.toUnwrapped(defaultValue: Date()), displayedComponents: .date)
                            .datePickerStyle(CompactDatePickerStyle()).font(.sprenLabel)
                            .onChange(of: birthdate) { value in SprenUI.config.userBirthdate = value }
                    }
                }.frame(maxWidth: 200)
                HStack{
                    Text("Gender:").font(.sprenLabel)
                    Picker("Please choose a gender", selection: $gender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: gender) { value in
                        switch (value){
                        case "male":
                            SprenUI.config.userGender = SprenUI.Config.Gender.male
                        case "female":
                            SprenUI.config.userGender = SprenUI.Config.Gender.female
                        default:
                            SprenUI.config.userGender = nil
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

extension Binding {
     func toUnwrapped<T>(defaultValue: T) -> Binding<T> where Value == Optional<T>  {
        Binding<T>(get: { self.wrappedValue ?? defaultValue }, set: { self.wrappedValue = $0 })
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
