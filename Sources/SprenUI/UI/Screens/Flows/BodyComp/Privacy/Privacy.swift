//
//  Privacy.swift
//  SprenInternal
//
//  Created by Fernando on 8/12/22.
//

import SwiftUI

struct Privacy: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            Color("AppBackground", bundle: .module).edgesIgnoringSafeArea(.all)
            
            VStack {
                CloseButton(action: {self.presentationMode.wrappedValue.dismiss()})
                
                Image("Privacy", bundle: .module).resizable()
                    .aspectRatio(contentMode: .fit)
                    .colorMultiply(Color.sprenUIColor1.opacity(0.75))
                
                title
                
                text
                
                Spacer()
            }.padding(.horizontal, Autoscale.convert(16))
        }.navigationBarHidden(true)
    }
    
    var title: some View {
        HStack {
            Text("Privacy and Security")
                .font(.sprenTitle)
                .lineLimit(1)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
                .padding(.top, Autoscale.convert(16))
                .padding(.bottom, Autoscale.convert(16))
            Spacer()
        }
    }
    
    var text: some View {
        HStack {
            Text("Your privacy and security are important!\n\nNo identifiable imagery leaves your phone. Your photo is de-identified prior to being transmitted to the cloud where our algorithms process and calculate your results. Once you receive your results, your unidentifiable photo is automatically deleted from the cloud.\n\nWe use world class encryption security and privacy measures when transmitting and storing any data that is used to provide you results and guidance.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading).padding(.bottom, Autoscale.convert(20))
            Spacer()
        }
    }
}

struct Privacy_Previews: PreviewProvider {
    static var previews: some View {
        Privacy()
    }
}
