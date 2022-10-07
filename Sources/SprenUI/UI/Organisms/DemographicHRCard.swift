//
//  SwiftUIView.swift
//
//
//  Created by Fernando on 9/29/22.
//

import SwiftUI

struct DemographicHRCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    let value: Double
    let age: Int?
    let gender: SprenUI.Config.BiologicalSex?
    
    var body: some View {
        let (classification, data, colorIndex) = getDataDemographicHRCard(value: value, age: age, gender: gender)
        let colors = ["DemographicGreen", "DemographicMediumGreen", "DemographicLightGreen", "DemographicYellow", "DemographicOrange", "DemographicRed"]
        
        VStack {
            VStack {
                HStack {
                    Score(value: "\(String(format: "%.0f", value))", unit: nil, color: Color(colors[colorIndex], bundle: .module))
                    
                    HStack {
                        Text("Resting Heart Rate")
                            .font(.sprenAlertTitle)
                            .sprenUIPadding([.leading])
                        Spacer()
                    }
                }.padding(.bottom, Autoscale.scaleFactor * 12)
                
                HStack {
                    Text("Your resting heart rate of \(String(format: "%.0f", value)) is "+classification+(age != nil && gender != nil && gender?.rawValue ?? nil != "other" ? " for \(gender!) your age": age != nil && gender != nil && gender?.rawValue ?? nil == "other" ? " for people your age" : " compared to the population."))
                        .font(.sprenLabel)
                    Spacer()
                }.sprenUIPadding([.bottom])
                
                HStack {
                    Text("HRV levels")
                        .font(.sprenLabelBold)
                    Spacer()
                }
                
                VStack {
                    DemographicItem(color: Color("DemographicGreen", bundle: .module), text: "Excellent", range: data[0])
                    DemographicItem(color: Color("DemographicMediumGreen", bundle: .module), text: "Very Good", range: data[1])
                    DemographicItem(color: Color("DemographicLightGreen", bundle: .module), text: "Better than Average", range: data[2])
                    DemographicItem(color: Color("DemographicYellow", bundle: .module), text: "Average", range: data[3])
                    DemographicItem(color: Color("DemographicOrange", bundle: .module), text: "Below Average", range: data[4])
                    DemographicItem(color: Color("DemographicRed", bundle: .module), text: "Poor", range: data[5])
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

func getDataDemographicHRCard(value: Double, age: Int?, gender: SprenUI.Config.BiologicalSex?) -> (String, [String], Int) {
    let names = ["Excellent","Very Good","Better than Average","Average","Below Average","Poor"]
    var data:Array<Int> = [47,56,57,63,64,70,71,78,79,86,87,97]
    
    if (age != nil && gender == nil){
        if(age! > 15 && age! < 20){
            data = [47,57,58,63,64,72,73,81,82,89,90,100]
        }
        
        if(age! > 19 && age! < 40){
            data = [47,56,57,63,64,70,71,78,79,86,87,97]
        }
        
        if(age! > 39 && age! < 60){
            data = [46,56,57,61,62,69,70,77,78,85,86,95]
        }
        
        if(age! > 59){
            data = [46,56,57,61,62,69,70,76,77,85,86,97]
        }
    }
    
    if (age != nil && gender == SprenUI.Config.BiologicalSex.female){
        if(age! > 15 && age! < 20){
            data = [50,61,62,68,69,76,77,84,85,93,94,102]
        }
        
        if(age! > 19 && age! < 40){
            data = [52,59,60,65,66,73,74,81,82,88,89,98]
        }
        
        if(age! > 39 && age! < 60){
            data = [51,58,59,63,64,70,71,78,79,85,86,96]
        }
        
        if(age! > 59){
            data = [52,58,59,63,64,69,70,77,78,85,86,95]
        }
    }
    
    if (age != nil && (gender == SprenUI.Config.BiologicalSex.male || gender == SprenUI.Config.BiologicalSex.other)){
        if(age! > 15 && age! < 20){
            data = [46,55,56,60,61,68,69,77,78,86,87,94]
        }
        
        if(age! > 19 && age! < 40){
            data = [47,54,55,60,61,68,69,75,76,83,84,94]
        }
        
        if(age! > 39 && age! < 60){
            data = [46,54,55,60,61,67,68,76,77,84,85,94]
        }
        
        if(age! > 59){
            data = [45,53,54,59,60,66,67,74,75,83,84,97]
        }
    }
    
    var dataLabel: Array<String> = []
    
    var i = Int(0)
    for index in data.indices {
        if (Double(data[index]) <= value) {
            i = index
        }
        
        if(dataLabel.indices.contains(Int(index/2))){
            dataLabel[Int(index/2)] += "-"+String(data[index])
        }else{
            dataLabel.append(String(data[index]))
        }
    }
    
    return (names[Int(i/2)],dataLabel, Int(i/2))
}

struct DemographicHRCard_Previews: PreviewProvider {
    static var previews: some View {
        DemographicHRCard(value: 63.1, age: 27, gender: SprenUI.Config.BiologicalSex.female)
    }
}
