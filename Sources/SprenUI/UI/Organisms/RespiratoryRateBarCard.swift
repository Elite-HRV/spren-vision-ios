//
//  SwiftUIView.swift
//  
//
//  Created by Fernando on 9/28/22.
//

import SwiftUI

struct RespiratoryRateBarCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    let breathingRate: Double
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Score(value: "\(String(format: "%.0f", breathingRate))", unit: "rpm", color: breathingRate >= RespiratoryConstants.rangeMin && breathingRate <= RespiratoryConstants.rangeMax ? Color.green : Color("Yellow", bundle: .module))
                    Text("Respiratory Rate").font(.sprenProgress).sprenUIPadding([.leading])
                    Spacer()
                }.sprenUIPadding([.bottom])
                
                HStack {
                    Text("Your respiratory rate of \(String(format: "%.0f", breathingRate)) rpm is normal for healthy adults.").font(.sprenLabel)
                    Spacer()
                }
                
                RespiratoryBar(breathingRate: breathingRate)
            }
            .sprenUIPadding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)
        }
        .sprenUIPadding()
    }
}

struct RespiratoryConstants {
     static let rangeMin: CGFloat = 12
     static let rangeMax: CGFloat = 20
 }

struct RespiratoryRateBarCard_Previews: PreviewProvider {
    static var previews: some View {
        RespiratoryRateBarCard(breathingRate: 14)
    }
}
