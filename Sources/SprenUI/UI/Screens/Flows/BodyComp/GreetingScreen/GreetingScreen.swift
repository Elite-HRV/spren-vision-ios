//
//  GreetingScreen.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI

struct GreetingScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isActive : Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                
                getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark).edgesIgnoringSafeArea(.all)
                
                VStack {
                    if SprenUI.config.bundle == .module {
                        Image(SprenUI.config.graphics[.greetings] ?? "", bundle: .module).resizable()
                            .aspectRatio(contentMode: .fit)
                            .colorMultiply(Color.sprenUISecondaryColor.opacity(0.75))
                            .padding(.top, Autoscale.convert(10))
                            .padding(.bottom, Autoscale.convert(10))
                    }else{
                        Image(SprenUI.config.graphics[.greetings] ?? "", bundle: .module).resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top, Autoscale.convert(10))
                            .padding(.bottom, Autoscale.convert(10))
                    }
                    
                    VStack {
                        title
                        
                        text
                        
                        links
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: WeightScreen(), isActive: self.$isActive) {
                        PurpleButton(text: "Try it now")
                    }
                }.padding(.horizontal, Autoscale.convert(16)).padding(.bottom, Autoscale.convert(10))
            }
            .navigationBarHidden(true)
        }.navigationViewStyle(StackNavigationViewStyle())
            .environment(\.rootPresentationMode, self.$isActive)
    }

    var title: some View {
        HStack {
            Text("Measure body fat composition with your phone camera")
                .font(.sprenTitle)
                .lineLimit(3)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
            Spacer()
        }.padding(.bottom, Autoscale.convert(10))
    }

    var text: some View {
        HStack {
            Text("Body composition provides a better picture of your health than weight or BMI alone.  Our accuracy is comparable to an in-laboratory DEXA scan.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading)
                .lineSpacing(Autoscale.convert(2))
            Spacer()
        }.frame(height: 100)
    }
    
    var links: some View {
        VStack {
            HStack {
                NavigationLink(destination: Accuracy()) {
                    Text("How accurate is this?")
                        .font(.sprenParagraphBold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.sprenUISecondaryColor)
                    Spacer()
                }
            }.padding(.top, Autoscale.convert(10))
            
            HStack {
                NavigationLink(destination: Privacy()) {
                    Text("Privacy and security")
                        .font(.sprenParagraphBold)
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.sprenUISecondaryColor)
                    Spacer()
                }
            }.padding(.top, Autoscale.convert(1)).padding(.bottom)
        }
    }
}

struct GreetingScreen_Previews: PreviewProvider {
    static var previews: some View {
        GreetingScreen()
    }
}
