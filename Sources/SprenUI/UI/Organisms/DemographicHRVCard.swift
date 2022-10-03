//
//  SwiftUIView.swift
//  
//
//  Created by Fernando on 9/29/22.
//

import SwiftUI

struct DemographicHRVCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    let value: Double
    let age: Int?
    let gender: SprenUI.Config.Gender?
    
    var body: some View {
        let (classification, data, colorIndex) = getDataDemographicHRVCard(value: value, age: age, gender: gender)
        let colors = ["DemographicGreen", "DemographicMediumGreen", "DemographicLightGreen", "DemographicYellow", "DemographicOrange", "DemographicRed"]
        
        VStack {
            VStack {
                HStack {
                    Score(value: "\(String(format: "%.0f", value))", unit: nil, color:  Color(colors[colorIndex], bundle: .module))
                    
                    HStack {
                        Text("HRV Score")
                            .font(.sprenAlertTitle)
                            .sprenUIPadding([.leading])
                        Spacer()
                    }
                }.padding(.bottom, Autoscale.scaleFactor * 12)
                
                HStack {
                    Text("Your HRV Score of \(String(format: "%.0f", value)) is "+classification+(age != nil && gender != nil ? " for \(gender!) your age": " compared to the population."))
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
                    DemographicItem(color: Color("DemographicLightGreen", bundle: .module), text: "Above Average", range: data[2])
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

func getDataDemographicHRVCard(value: Double, age: Int?, gender: SprenUI.Config.Gender?) -> (String, [String], Int) {
    let names = ["Excellent","Very Good","Above Average","Average","Below Average","Poor"]
    var data:Array<Int> = [72,100,66,71,60,65,53,59,46,52,1,45]
    
    if (age != nil && gender == SprenUI.Config.Gender.female){
        if(age! > 17 && age! < 30){
            data = [73,78,70,73,65,70,59,65,50,59,30,50]
        }
        
        if(age! > 29 && age! < 40){
            data = [72,79,68,72,61,68,55,61,48,55,36,48]
        }
        
        if(age! > 39 && age! < 50){
            data = [69,76,64,69,58,64,51,58,43,51,32,43]
        }
        
        if(age! > 49 && age! < 60){
            data = [67,74,62,67,56,62,50,56,45,50,35,45]
        }
        
        if(age! > 59 && age! < 70){
            data = [65,74,59,65,53,59,47,53,40,47,28,40]
        }
        
        if(age! > 69){
            data = [65,73,59,65,51,59,42,51,38,42,32,38]
        }
    }

    if (age != nil && gender == SprenUI.Config.Gender.male){
        if(age! > 17 && age! < 30){
            data = [75,100,71,75,67,71,61,67,53,61,41,53]
        }
        
        if(age! > 29 && age! < 40){
            data = [72,100,69,72,63,69,57,63,51,57,38,51]
        }
        
        if(age! > 39 && age! < 50){
            data = [70,100,66,70,60,66,54,60,48,54,35,48]
        }
        
        if(age! > 49 && age! < 60){
            data = [68,100,62,68,56,62,50,56,45,50,33,45]
        }
        
        if(age! > 59 && age! < 70){
            data = [67,100,61,67,54,61,48,54,42,48,30,42]
        }
        
        if(age! > 69){
            data = [69,100,62,69,55,62,47,55,39,47,26,39]
        }
    }

    var dataLabel: Array<String> = []
    
    var i = Int(0)
    for index in data.indices {
        if (Double(data[index]) >= value) {
            i = index
        }
        
        if(dataLabel.indices.contains(Int(index/2))){
            dataLabel[Int(index/2)] += "-"+String(data[index])
        }else{
            dataLabel.append(String(data[index]))
        }
    }
    
    return (names[Int(i/2)],dataLabel,Int(i/2))
}

struct DemographicHRVCard_Previews: PreviewProvider {
    static var previews: some View {
        DemographicHRVCard(value: 63.1, age: nil, gender: nil)
    }
}
