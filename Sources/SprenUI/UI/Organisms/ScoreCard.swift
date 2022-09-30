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
    let age: Int?
    let gender: String?
    
    var body: some View {
        let (color, title, value, text, labelText, unit) = getScoreCardData(type: type, results: results, age: age, gender: gender)
        
        VStack {
            VStack {
                HStack {
                    Score(value: value, unit: unit, color: color)
                    
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
                            .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                            .padding(.horizontal, Autoscale.scaleFactor * 10)
                            .padding(.vertical, Autoscale.scaleFactor * 2)
                    }.background(color).cornerRadius(16)
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

func getScoreCardData(type: String, results: Results, age: Int?, gender: String?) -> (Color, String, String, String, String, String?) {
    switch type {
    case "hrvScore":
        let (_, _, index) = getDataDemographicHRVCard(value: results.hr, age: age, gender: gender)
        var text = age != nil && gender != nil ? "Better than average for your age and gender" : "Better than the population average"
        var color = Color("DemographicGreen", bundle: .module)
        
        if(index == 3){
            text = age != nil && gender != nil ? "Average for your age and gender" : "Average compared to population"
        }
        
        if(index > 3){
            color = Color("DemographicOrange", bundle: .module)
            text = age != nil && gender != nil ? "Below average for your age and gender" : "Below the population average"
        }
        
        return (color, "HRV score", "\(String(format: "%.0f", results.hrvScore))", "HRV is an indicator of overall health and fitness. A higher HRV score means better health and fitness and lower stress.", text, nil)
    case "hr":
        let (_, _, index) = getDataDemographicHRCard(value: results.hr, age: age, gender: gender)
        var text = age != nil && gender != nil ? "Better than average for your age and gender" : "Better than the population average"
        var color = Color("DemographicGreen", bundle: .module)
        
        if(index == 3){
            text = age != nil && gender != nil ? "Average for your age and gender" : "Average compared to population"
        }
        
        if(index > 3){
            color = Color("DemographicOrange", bundle: .module)
            text = age != nil && gender != nil ? "Below average for your age and gender" : "Below the population average"
        }
        
        return (color, "Heart rate", "\(String(format: "%.0f", results.hr))", "Resting heart rate can reflect your current and future health. A lower heart rate indicates better cardiovascular fitness and increased longevity.", text, "bpm")
    default:
        var text = "Normal for your age and gender"
        var color: Color = Color("DemographicGreen", bundle: .module)
        
        if(results.breathingRate < RespiratoryConstants.rangeMin){
            color = Color("DemographicOrange", bundle: .module)
            text = "Abnormally low for healthy adults"
        }
        
        if(results.breathingRate > RespiratoryConstants.rangeMax){
            color = Color("DemographicOrange", bundle: .module)
            text = "Abnormally high for healthy adults"
        }
        
        return (color, "Respiration", "\(String(format: "%.0f", results.breathingRate))", "Resting respiratory rate is a key indicator of health. Changes in daily resting respiration can indicate recovery issues or illness onset.", text, "rpm")
    }
}

struct ScoreCard_Previews: PreviewProvider {
    static var previews: some View {
        ScoreCard(results: .init(guid: "",
                                 hr: 58.9,
                                 hrvScore: 63.1,
                                 rmssd: 0.3,
                                 breathingRate: 11,
                                 readiness: nil,
                                 ansBalance: nil,
                                 signalQuality: 2), type: "hrvScore", age: nil, gender: nil)
    }
}
