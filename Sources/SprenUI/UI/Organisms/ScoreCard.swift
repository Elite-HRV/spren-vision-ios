//
//  SwiftUIView.swift
//  
//
//  Created by Fernando on 9/27/22.
//

import SwiftUI

struct ScoreCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    let results: Results
    let type: String
    
    var body: some View {
        let (title, value, text, labelText, unit) = getScoreCardData(type: type, results: results)
        
        VStack {
            VStack {
                HStack {
                    Score(value: value, unit: unit, color: Color("LightGreen", bundle: .module))
                    
                    HStack {
                        Text(title)
                            .font(.sprenAlertTitle)
                            .sprenUIPadding([.leading])
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }.sprenUIPadding([.bottom])
                
                Text(text)
                    .font(.sprenLabel)
                    .lineSpacing(Autoscale.scaleFactor * 4)
                    .sprenUIPadding([.bottom])
                
                HStack{
                    VStack {
                        Text(labelText)
                            .font(.sprenLabelSmallBold)
                            .foregroundColor(Color.white)
                            .padding(.horizontal, Autoscale.scaleFactor * 10)
                            .padding(.vertical, Autoscale.scaleFactor * 2)
                    }.background(Color.green).cornerRadius(16)
                    Spacer()
                }
            }
            .sprenUIPadding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)
        }
        .sprenUIPadding()
    }
}

func getScoreCardData(type: String, results: Results) -> (String, String, String, String, String?) {
    switch type {
    case "hrvScore":
        return ("HRV score", "\(String(format: "%.0f", results.hrvScore))", "HRV is an indicator of overall health and fitness. A higher HRV score means better health and fitness and lower stress.", "Better than average for your age and gender", nil)
    case "hr":
        return ("Heart rate", "\(String(format: "%.0f", results.hr))", "Resting heart rate can reflect your current and future health. A lower heart rate indicates better cardiovascular fitness and increased longevity.", "Better that average for your age and gender", "bpm")
    default:
        return ("Respiration", "\(String(format: "%.0f", results.breathingRate))", "Resting respiratory rate is a key indicator of health. Changes in daily resting respiration can indicate recovery issues or illness onset.", "Normal for your age and gender", "rpm")
    }
}

struct ScoreCard_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCard(results: .init(guid: "",
                                 hr: 58.9,
                                 hrvScore: 63.1,
                                 rmssd: 0.3,
                                 breathingRate: 12,
                                 readiness: nil,
                                 ansBalance: nil,
                                 signalQuality: 2), type: "hrvScore")
    }
}
