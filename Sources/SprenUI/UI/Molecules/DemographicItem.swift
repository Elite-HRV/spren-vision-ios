//
//  SwiftUIView.swift
//  
//
//  Created by Fernando on 9/29/22.
//

import SwiftUI

struct DemographicItem: View {
    let color: Color
    let text: String
    let range: String
    
    var body: some View {
        HStack {
            VStack {}
            .frame(width: Autoscale.scaleFactor * 20, height: Autoscale.scaleFactor * 20)
            .background(color).cornerRadius(4)
     
            Text(text).font(.sprenLabel)
            
            Spacer()
            
            Text(range).font(.sprenLabel)
        }
    }
}

struct DemographicItem_Previews: PreviewProvider {
    static var previews: some View {
        DemographicItem(color: Color.green, text: "Excellent", range: "85-100")
    }
}
