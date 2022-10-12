//
//  DemographicRow.swift
//  
//
//  Created by Fernando on 9/29/22.
//

import SwiftUI

struct DemographicRow: View {
    let color: Color
    let text: String
    let range: String
    
    let colorSize = 20*Autoscale.scaleFactor
    
    var body: some View {
        HStack {
            color
                .frame(width: colorSize, height: colorSize)
                .cornerRadius(4)
     
            Text(text)
                .font(.sprenLabel)
            
            Spacer()
            
            Text(range)
                .font(.sprenLabel)
        }
    }
}

struct DemographicRow_Previews: PreviewProvider {
    static var previews: some View {
        DemographicRow(color: Color.green, text: "Excellent", range: "85-100")
    }
}
