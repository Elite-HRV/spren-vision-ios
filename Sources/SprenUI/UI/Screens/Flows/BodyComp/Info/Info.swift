//
//  Info.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 28/07/22.
//

import SwiftUI

struct Info: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark).edgesIgnoringSafeArea(.all)
            
            ScrollView {                
                VStack(spacing: Autoscale.convert(20)) {
                    InfoBox(title: "Body Fat Percentage", text: "This is the percentage of your total body weight that is made up of fat mass.")
                    
                    InfoBox(title: "Lean Mass", text: "Fat Free Mass collectively refers to the combination of Lean Soft Tissue (muscle), water, and bone. Skeletal muscle is the largest body component in adults, and accounts for about 40% of your total body weight.")

                    InfoBox(title: "Fat Mass", text: "Fat Mass describes how much adipose tissue is in your body, and is measured in pounds or kilograms.")
                    
                    InfoBox(title: "Body Weight", text: "Your weight is often used as a crude measure of health. This number is often used to calculate Body Mass Index, which expresses your weight in relation to your height. Adopting a “one-size-fits all” approach for determining a healthy weight or Body Mass Index is misleading, as body composition can vary by age, race, gender, and physical activity level across individuals with the same body weight.")
                    
                    InfoBox(title: "Android Fat", text: "Android fat (i.e. the “apple shape”) is more common among men. This fat is stored primarily around the abdomen and waist, and this distribution pattern is often related to higher risk for obesity-related health complications.")
                    
                    InfoBox(title: "Gynoid Fat", text: "Gynoid fat (i.e. the “pear shape”) is more common among women. This fat is stored primarily around the hips and thighs, and this distribution pattern is often considered healthier because it is related to lower risk of obesity-related health complications.")
                    
                    InfoBox(title: "Android:Gynoid Ratio", text: "The ratio for android fat storage to gynoid fat storage is correlated with metabolic insulin resistance, matabolic disregulation, and risk of cardiovasular disease. A higher value of Android:Gynoid fat ratio indicates an increased risk for metabolic and cardiovascular diseases due to increased visceral fat storage. It is ideal to have a Android: Gynoid Fat ratio less than 1.0.")
                    
                    InfoBox(title: "Resting Metabolic Rate", text: "Resting metabolic rate is the total number of calories burned when your body is completely at rest. This information could be helpful for a person who is trying to manage their weight.")
                    
                    Spacer()
                    
                    Image("PoweredBySpren", bundle: .module)
                        .padding(Autoscale.padding)
                }
                .padding(.horizontal, Autoscale.convert(16)).padding(.top, Autoscale.convert(40))
            }.padding(.top, 0.1)
        }
        .navigationBarTitle(Text("Learn more"), displayMode: .inline)
    }
}

struct Info_Previews: PreviewProvider {
    static var previews: some View {
        Info()
    }
}
