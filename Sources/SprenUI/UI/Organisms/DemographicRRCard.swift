//
//  DemographicRRCard.swift
//  
//
//  Created by Fernando on 9/28/22.
//

import SwiftUI

struct DemographicRRCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    let breathingRate: Double
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    ResultCircle(value: "\(String(format: "%.0f", breathingRate))",
                                 unit: "rpm",
                                 color: RRConstants.getColor(value: breathingRate))
                    Text("Respiratory Rate")
                        .font(.sprenProgress)
                        .sprenUIPadding([.leading])
                    Spacer()
                }.sprenUIPadding([.bottom])
                
                HStack {
                    Text("Your respiratory rate of \(String(format: "%.0f", breathingRate)) rpm is \(RRConstants.getClassification(value: breathingRate)) for healthy adults.")
                        .font(.sprenLabel)
                    Spacer()
                }
                
                RRBar(breathingRate: breathingRate)
            }
            .sprenUIPadding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)
        }
        .sprenUIPadding()
    }
}

struct RRConstants {
    static let rangeMin: CGFloat = 12
    static let rangeMax: CGFloat = 20
    
    static func getClassification(value: Double) -> String {
        if value < 12 {
            return "abnormally low"
        }
        if 12 <= value && value <= 20 {
            return "normal"
        }
        return "abnormally high"
    }
    
    static func getColor(value: Double) -> Color {
        if value < 12 {
            return Color("Yellow", bundle: .module)
        }
        if 12 <= value && value <= 20 {
            return .green
        }
        return Color("Yellow", bundle: .module)
    }
}

struct RespiratoryRateBarCard_Previews: PreviewProvider {
    static var previews: some View {
        DemographicRRCard(breathingRate: 14)
    }
}
