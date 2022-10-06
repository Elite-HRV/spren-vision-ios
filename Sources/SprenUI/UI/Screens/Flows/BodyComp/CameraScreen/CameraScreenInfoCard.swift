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
        
            HStack(alignment: .top) {
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)

                Text("Please stand with your feet together and your arms out at 45 degrees.   Make sure your whole body is in the picture.  Match the guide. The indicators will turn green when you are in the correct position.")
                    .font(.sprenLabel)
                    .lineLimit(10)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(.white)
                    .padding(.leading, Autoscale.convert(15))

            }.padding(Autoscale.convert(24))
        }.frame(height: Autoscale.convert(170)).cornerRadius(Autoscale.convert(15)).padding()
    }
}

struct CameraScreenInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreenInfoCard()
    }
}
