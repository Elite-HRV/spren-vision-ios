//
//  IncorrectBodyPosition.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 29/07/22.
//

import SwiftUI

struct IncorrectBodyPosition: View {
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    @State private var navigateTo: String?
    
    var body: some View {
        ZStack {
            NavigationLink(destination: SetupGuide(), tag: "SetupGuide", selection: $navigateTo) { EmptyView() }

            Color("AppBackground", bundle: .module).edgesIgnoringSafeArea(.all)
            
            VStack {
                CloseButton(action: {self.rootPresentationMode.wrappedValue.dismiss()})
                
                if (SprenUI.config.bundle == .module) {
                    Image(SprenUI.config.graphics[.incorrectBodyPosition] ?? "", bundle: .module).resizable()
                        .aspectRatio(contentMode: .fit)
                        .colorMultiply(Color.sprenUIColor1.opacity(0.75))
                        .frame(maxHeight: Autoscale.convert(280))
                } else {
                    Image(SprenUI.config.graphics[.incorrectBodyPosition] ?? "", bundle: .module).resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: Autoscale.convert(280))
                }

                title
                
                text.padding(.bottom)
                
                tips
                
                Spacer()
                
                Button {
                    navigateTo = "SetupGuide"
                } label: {
                    PurpleButton(text: "Try again").padding(.top)
                }
                
            }.padding(.horizontal, Autoscale.convert(16)).padding(.bottom, Autoscale.convert(10))
        }.navigationBarHidden(true)
    }
    
    var title: some View {
        HStack {
            Text("Sorry, we couldn’t calculate your results")
                .font(.title)
                .lineLimit(2)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
                .padding(.top, Autoscale.convert(10)).padding(.bottom, Autoscale.convert(5))
            Spacer()
        }
    }

    var text: some View {
        HStack {
            Text("Unfortunately, we couldn’t accurately calculate your results due to incorrect body position. Please take another picture to view your body composition results.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading)
                .lineSpacing(Autoscale.convert(3))
            Spacer()
        }
    }
    
    var tips: some View {
        VStack(spacing: Autoscale.convert(8)) {
            HStack {
                Text("Tips")
                    .font(.sprenButton)
                Spacer()
            }
            
            IncorrectBodyPositionTip(text: "Center your whole body in the photo")
            IncorrectBodyPositionTip(text: "Stand with your feet and heels together")
            IncorrectBodyPositionTip(text: "Put your arms out around 45 degrees from your body")
        }.frame(minHeight: 130)
    }
}

struct IncorrectBodyPosition_Previews: PreviewProvider {
    static var previews: some View {
        IncorrectBodyPosition()
    }
}
