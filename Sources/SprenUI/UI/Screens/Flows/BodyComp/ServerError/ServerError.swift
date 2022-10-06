//
//  ServerError.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 29/07/22.
//

import SwiftUI

struct ServerError: View {
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    @State private var navigateTo: String?
    
    var body: some View {
        ZStack {
            NavigationLink(destination: SetupGuide(), tag: "SetupGuide", selection: $navigateTo) { EmptyView() }
            Color("AppBackground", bundle: .module).edgesIgnoringSafeArea(.all)
            
            VStack {
                CloseButton(action: {self.rootPresentationMode.wrappedValue.dismiss()})
                
                Image("ServerError", bundle: .module).resizable()
                    .aspectRatio(contentMode: .fit).frame(maxHeight: Autoscale.convert(280))
                
                title
                
                text
                
                Spacer()
                
                Button {
                    navigateTo = "SetupGuide"
                } label: {
                    PurpleButton(text: "Try again")
                }
                
            }.padding(.horizontal, Autoscale.convert(16)).padding(.bottom, Autoscale.convert(10))
        }.navigationBarHidden(true)
    }
    
    var title: some View {
        HStack {
            Text("Sorry! There was an error calculating your results")
                .font(.sprenTitle)
                .lineLimit(3)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
                .padding(.top, Autoscale.convert(10)).padding(.bottom, Autoscale.convert(16))
            Spacer()
        }
    }

    var text: some View {
        HStack {
            Text("Please take another photo to view your body composition results.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading)
                .lineSpacing(Autoscale.convert(3))
            Spacer()
        }
    }
}

struct ServerError_Previews: PreviewProvider {
    static var previews: some View {
        ServerError()
    }
}
