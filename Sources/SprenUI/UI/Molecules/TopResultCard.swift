//
//  ResultCard.swift
//  
//
//  Created by Fernando on 9/27/22.
//

import SwiftUI

struct ResultCard: View {
    
    @Environment(\.colorScheme) var colorScheme

    let value: Double
    let type: `Type`
    let age = SprenUI.config.userBirthdate?.age
    let gender = SprenUI.config.userGender
    
    enum `Type` {
        case hrvScore
        case hr
        case breathingRate
    }
    
    let colors = [
        "DemographicGreen",
        "DemographicMediumGreen",
        "DemographicLightGreen",
        "DemographicYellow",
        "DemographicOrange",
        "DemographicRed"
    ]
    
    var body: some View {
        let (circleColor, labelColor, title, text, labelText, unit) = getResultCardData(type: type, age: age, gender: gender)
        
        VStack {
            VStack {
                HStack {
                    ResultCircle(value: "\(String(format: "%.0f", value))",
                                 unit: unit,
                                 color: circleColor)
                    Text(title)
                        .font(.sprenAlertTitle)
                        .sprenUIPadding(.leading)
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .sprenUIPadding(.bottom)
                
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
                    }
                    .background(labelColor)
                    .cornerRadius(16)
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

extension ResultCard {
    func getResultCardData(type: Self.`Type`, age: Int?, gender: BiologicalSex?) -> (Color, Color, String, String, String, String?) {
        switch type {
        case .hrvScore:
            let (_, _, index) = DemographicHRVCard.getDataDemographicHRVCard(value: value, age: age, gender: gender)
            
            let color1 = Color(colors[index], bundle: .module)
            var color2 = Color("DemographicGreen", bundle: .module)
            
            var text = age != nil && gender != nil ? "Better than average for your age and gender" : "Better than the population average"
            
            if(index == 3){
                text = age != nil && gender != nil ? "Average for your age and gender" : "Average compared to population"
            }
            
            if(index > 3){
                color2 = Color("DemographicOrange", bundle: .module)
                text = age != nil && gender != nil ? "Below average for your age and gender" : "Below the population average"
            }
            
            return (color1, color2, "HRV score", "HRV is an indicator of overall health and fitness. A higher HRV score means better health and fitness and lower stress.", text, nil)
        case .hr:
            let (_, _, index) = DemographicHRCard.getDataDemographicHRCard(value: value, age: age, gender: gender)
            let color1 = Color(colors[index], bundle: .module)
            var color2 = Color("DemographicGreen", bundle: .module)
            
            var text = age != nil && gender != nil ? "Better than average for your age and gender" : "Better than the population average"
            
            if(index == 3){
                text = age != nil && gender != nil ? "Average for your age and gender" : "Average compared to population"
            }
            
            if(index > 3){
                color2 = Color("DemographicOrange", bundle: .module)
                text = age != nil && gender != nil ? "Below average for your age and gender" : "Below the population average"
            }
            
            return (color1, color2, "Heart rate", "Resting heart rate can reflect your current and future health. A lower heart rate indicates better cardiovascular fitness and increased longevity.", text, "bpm")
        case .breathingRate:
            var text = "Normal for your age and gender"
            var color: Color = Color("DemographicGreen", bundle: .module)
            
            if (value < RRConstants.rangeMin) {
                color = Color("DemographicOrange", bundle: .module)
                text = "Abnormally low for healthy adults"
            }
            
            if (value > RRConstants.rangeMax) {
                color = Color("DemographicOrange", bundle: .module)
                text = "Abnormally high for healthy adults"
            }
            
            return (color, color, "Respiration", "Resting respiratory rate is a key indicator of health. Changes in daily resting respiration can indicate recovery issues or illness onset.", text, "rpm")
        }
    }

}

struct ResultCard_Previews: PreviewProvider {
    static var previews: some View {
        ResultCard(value: 53, type: .hrvScore)
        ResultCard(value: 58.9, type: .hr)
        ResultCard(value: 11, type: .breathingRate)
    }
}
