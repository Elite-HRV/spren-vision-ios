//
//  CameraScreenInfoCard.swift
//  SprenInternal
//
//  Created by Fernando on 8/18/22.
//

import SwiftUI

struct CameraScreenInfoCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .dark)).edgesIgnoringSafeArea(.bottom)
        
            VStack(spacing:Autoscale.convert(10)) {
                
                if SprenUI.config.bundle == .module {
                    Image(SprenUI.config.graphics[.bodyPosition] ?? "", bundle: .module).resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: Autoscale.convert(88))
                        .padding(.top, Autoscale.convert(10))
                        .padding(.bottom, Autoscale.convert(10))

                }else{
                    Image(SprenUI.config.graphics[.bodyPosition] ?? "", bundle: .module).resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: Autoscale.convert(88))
                        .padding(.top, Autoscale.convert(10))
                        .padding(.bottom, Autoscale.convert(10))

                }

                HStack {
                    Text("• Center your whole body in frame")
                        .multilineTextAlignment(.leading)
                        .font(.sprenParagraph)
                        .foregroundColor(.white)
                    Spacer()
                }

                HStack {
                    Text("• Stand with your feet together")
                        .multilineTextAlignment(.leading)
                        .font(.sprenParagraph)
                        .foregroundColor(.white)
                    Spacer()
                }

                HStack {
                    Text("• Put your arms out at 45 degrees")
                        .multilineTextAlignment(.leading)
                        .font(.sprenParagraph)
                        .foregroundColor(.white)
                    Spacer()
                }
            }.padding(Autoscale.convert(24))
        }.fixedSize(horizontal: false, vertical: true).cornerRadius(Autoscale.convert(15)).padding()
    }
}

struct CameraScreenInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreenInfoCard()
    }
}
