//
//  SwiftUIView.swift
//  
//
//  Created by Fernando on 9/28/22.
//

import SwiftUI

struct Score: View {
    let value: String
    let unit: String?
    let color: Color
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(color, style: StrokeStyle(lineWidth: 3))
                .frame(height: 72)
            VStack {
                Text(value)
                    .font(.sprenAlertTitle)
                    .padding(.bottom, unit != nil ? -15 : 0)
                if(unit != nil){
                    Text(unit!)
                        .font(.sprenLabelSmall)
                }
            }
        }
    }
}

struct Score_Previews: PreviewProvider {
    static var previews: some View {
        Score(value: "17", unit: "rpm", color: Color("LightGreen", bundle: .module))
    }
}
