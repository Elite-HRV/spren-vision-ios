//
//  InfoScreen.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

struct InfoScreen: View {
        
    @Environment(\.colorScheme) var colorScheme
    
    let navBarTitle: String
    let title: String
    let paragraph1: String
    let illustration: String
    let paragraph2: String
    
    let onBackButtonTap: () -> Void
    
    var body: some View {
        ScrollView {
            
            // heading
            ZStack {
                Text(navBarTitle)
                    .font(.sprenButton)
                
                HStack {
                    Button(action: onBackButtonTap, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    })
                    .padding(Autoscale.padding)
                    Spacer()
                }
            }
            .background(colorScheme == .light ? Color.white : Color.black)
            
            VStack(alignment: .leading, spacing: 0) {
                // title
                HStack {
                    Text(title)
                        .font(.sprenAlertTitle)
                    Spacer()
                }
                .padding([.leading, .bottom, .trailing])
                
                // paragraph 1
                Text(paragraph1)
                    .font(.sprenParagraph)
                    .padding([.leading, .bottom, .trailing])
                
                // illustration
                HStack {
                    Spacer()
                    Image(illustration, bundle: .module)
                        .padding()
                    Spacer()
                }
                
                // paragraph 2
                Text(paragraph2)
                    .font(.sprenParagraph)
                    .padding()
            }
            .padding()
            
        }
        .background(colorScheme == .light ? Color.offWhite : Color.offBlack)
    }
    
}

struct InfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        InfoScreen(navBarTitle: "Recovery",
                   title: "Recovery",
                   paragraph1: "Your Recovery Score is a personalized daily score that quantifies how recovered you are and how ready you are to take on the day.\n\nThis 1-10 score uses key heart rate and heart rate variability (HRV) metrics to learn your personal patterns and provide insight into how your body is adapting to things like exercise, stress, nutrition, work, and more. It helps you understand when your body is ready to perform and when you need to focus on rest and recovery.",
                   illustration: "Recovery",
                   paragraph2: "",
                   onBackButtonTap: {})
        
        InfoScreen(navBarTitle: "ANS Balance",
                   title: "ANS Balance",
                   paragraph1: "The autonomic nervous system (ANS) controls almost all of the body’s “automatic” processes. It regulates bodily functions such as heart rate, blood sugar, blood pressure, temperature, energy, digestion, sexual function, tissue repair, and more.",
                   illustration: "ANSBalance",
                   paragraph2: "The ANS Balance indicates the relative balance between thethe SNS and PSNS, thus indicating the balance between recovery and physiological stress (both physical and mental).\n\nKnowing the relative balance of the ANS helps you better understand the current state of your body and determine the best course of action towards reaching your goals without working against yourself.",
                   onBackButtonTap: {})
    }
}
