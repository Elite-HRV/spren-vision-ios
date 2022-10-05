//
//  GreetingScreen.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI

struct GreetingScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            
            Color("AppBackground").edgesIgnoringSafeArea(.all)
            
            VStack {
                CloseButton(action: {self.presentationMode.wrappedValue.dismiss()})
                
                Image("GreetingsImage", bundle: .module).resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top, Autoscale.convert(10))
                    .padding(.bottom, Autoscale.convert(10))

                VStack {
                    title

                    text
                    
                    links
                }

                Spacer()

                NavigationLink(destination: WeightScreen()) {
                    PurpleButton(text: "Try it now")
                }
            }.padding(.horizontal, Autoscale.convert(16)).padding(.bottom, Autoscale.convert(10))
        }
        .navigationBarHidden(true)
    }

    var title: some View {
        HStack {
            Text("Measure body fat composition with your phone camera")
                .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 30))
                .lineLimit(3)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
            Spacer()
        }.padding(.bottom, Autoscale.convert(10))
    }

    var text: some View {
        HStack {
            Text("Body composition provides a better picture of your health than weight or BMI alone.  Our accuracy is comparable to an in-laboratory DEXA scan.")
                .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16))
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
                        .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("Red", bundle: .module))
                    Spacer()
                }
            }.padding(.top, Autoscale.convert(10))
            
            HStack {
                NavigationLink(destination: Privacy()) {
                    Text("Privacy and security")
                        .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 16))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color("Red", bundle: .module))
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
