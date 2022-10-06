//
//  ConfirmationScreenParameters.swift
//  SprenInternal
//
//  Created by Fernando on 8/24/22.
//

import SwiftUI

struct ConfirmationScreenParameters: View {
    @Environment(\.colorScheme) var colorScheme
    
    var age: Int
    var weight: Double
    var weightMetric: Int
    var biologicalSex: Int
    var fitnessLevel: Int
    var height: HeightSize  
    
    var body: some View {
        ZStack {
            Color(colorScheme == .light ? .white : .black)
            
            HStack {
                VStack(alignment: .leading, spacing: Autoscale.convert(8)) {
                    VStack(alignment: .leading, spacing: Autoscale.convert(4)) {
                        Text("Weight: ").font(.sprenLabel)
                            .foregroundColor(Color("LightGrey", bundle: .module))
                        Text(String(weight) + " \(UserData.weightMetricLables[weightMetric])").font(.sprenParagraph)
                        
                        Text("Age: ").font(.sprenLabel)
                            .foregroundColor(Color("LightGrey", bundle: .module))
                        Text("\(age)").font(.sprenParagraph)
                        
                        Text("Recent activity level: ").font(.sprenLabel)
                            .foregroundColor(Color("LightGrey", bundle: .module))
                        Text("\(fitnessLevel) days per week").font(.sprenParagraph)
                    }
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: Autoscale.convert(8)) {
                    VStack(alignment: .leading, spacing: Autoscale.convert(4)) {
                        Text("Height: ").font(.sprenLabel)
                            .foregroundColor(Color("LightGrey", bundle: .module))
                        
                        if(height.unit == HeightSize.Unit.ft_in) {
                            Text("\(height.feet) feet \(height.inches) inches").font(.sprenParagraph)
                        } else {
                            Text("\(height.centimeters) cm ").font(.sprenParagraph)
                        }
                        
                        Text("Gender: ").font(.sprenLabel)
                            .foregroundColor(Color("LightGrey", bundle: .module))
                        Text(biologicalSex == 1 ? "Female" : biologicalSex == 2 ? "Other" : "Male").font(.sprenParagraph)
                    }
                }
            }.padding(Autoscale.convert(16))
        }.cornerRadius(Autoscale.convert(16)).padding(.bottom, Autoscale.convert(10))
    }
}

struct ConfirmationScreenParameters_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationScreenParameters(age: 0, weight: 0, weightMetric: 0, biologicalSex: 0, fitnessLevel: 0, height: UserData.getHeight())
    }
}
