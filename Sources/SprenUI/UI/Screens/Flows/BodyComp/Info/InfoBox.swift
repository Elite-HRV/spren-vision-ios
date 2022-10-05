//
//  InfoBox.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 28/07/22.
//

import SwiftUI

struct InfoBox: View {
    
    var title: String
    var text: String
    
    var body: some View {
        VStack(spacing: Autoscale.convert(8)) {
            HStack {
                Text(title)
                    .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor*20))
                    .lineLimit(1)
                    .minimumScaleFactor(0.01)
                    .foregroundColor(Color("AppBlack", bundle: .module)).multilineTextAlignment(.leading)
                
                Spacer()
            }
            
            HStack {
                Text(text)
                    .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor*14))
                    .foregroundColor(Color("AppBlack", bundle: .module)).multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
        .frame(width: .infinity)
        .padding(.horizontal, Autoscale.convert(15)).padding(.vertical, Autoscale.convert(20))
        .background(Color.white)
        .cornerRadius(Autoscale.convert(16))
        .shadow(color: Color("Shaddow", bundle: .module), radius: Autoscale.convert(7), x: 0, y: Autoscale.convert(10))
    }
}

struct InfoBox_Previews: PreviewProvider {
    static var previews: some View {
        InfoBox(title: "Body Fat Percentage", text: "This is the percentage of your total body weight that is made up of fat mass.")
    }
}
