//
//  ResultsScreen.swift
//  SprenInternal
//
//  Created by Keith Carolus on 2/3/22.
//

import SwiftUI

struct ResultsScreen: View {
    
    @Environment(\.openURL) var openURL
    
    let onDoneButtonTap: () -> Void
    
    let hrvScore: Double
    let hr: Double
    
    var body: some View {
        ScrollView {
            
            VStack {
                HStack {
                    Button(action: onDoneButtonTap, label: {
                        Text("Done")
                            .font(.sprenProgress)
                            .foregroundColor(.sprenPurple)
                    })
                    .padding(Autoscale.padding)
                    Spacer()
                }
                
                Text("Congrats!")
                    .font(.sprenTitle)
                    .padding(.bottom, Autoscale.scaleFactor*3)
                
                Text("You just completed a heart rate variability (HRV) reading using your smartphone camera.")
                    .font(.sprenParagraph)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .padding([.leading, .trailing, .bottom], Autoscale.padding)
                
                HStack {
                    VStack {
                        Text(String(format: "%.0f", hrvScore.rounded(.toNearestOrEven)))
                            .font(.sprenNumber)
                        Text("HRV Score")
                            .font(.sprenParagraph)
                    }
                    Image("HeartSignal", bundle: .module)
                    VStack {
                        Text(String(format: "%.0f", hr.rounded(.toNearestOrEven)))
                            .font(.sprenNumber)
                        Text("Heart Rate")
                            .font(.sprenParagraph)
                    }
                }
                .padding()
                
                VStack {
                    Text("Population Comparison")
                        .font(.sprenAlertTitle)
                        .padding(Autoscale.padding)
                    
                    Text("Compare yourself against the average HRV range of Spren's global population.*")
                        .font(.sprenParagraph)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .padding([.leading, .trailing, .bottom], Autoscale.padding)
                    
                    RangeBar(value: Int(hrvScore.rounded(.toNearestOrEven)))
                        .padding(.bottom, 2*Autoscale.padding)
                }
                .background(Color.gray.opacity(0.1))
                .padding(Autoscale.padding)
                
                Group {
                
                    Text("Unlock biomarkers and insights for your users!")
                        .font(.sprenTitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(Autoscale.padding)
                                        
                    Text("How are brands using Spren?")
                        .font(.sprenSubtitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text(" •  Personalize training programs\n •  Measure stress and recovery\n •  Quantify well-being outcomes")
                        .font(.sprenParagraph)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, Autoscale.padding)
                    
                    Text("Tap below for examples of how you can elevate your offering simply by integrating Spren into your app.")
                        .font(.sprenSubtitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(Autoscale.padding)
                    
                    SprenButton(title: "See how Spren can help", action: {
                        if let url = URL(string: "https://spren.app.link/e/see-more-spren-demo") {
                            openURL(url)
                        }
                    })
                    .padding(Autoscale.padding)
                    
                    Spacer()
                    Text("* For investigational use only. These numbers are estimates and not a substitute for the judgment of a health care professional. They are intended to improve awareness of general fitness and wellness.")
                        .font(.disclaimer)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.sprenGray)
                        .padding([.top,.leading,.trailing], Autoscale.padding)
                    Image("PoweredBySpren", bundle: .module)
                        .padding(Autoscale.padding)
                    
                }
                
            }
            
        }
    }
}

struct ResultsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultsScreen(onDoneButtonTap: {}, hrvScore: 63.1, hr: 58.9)
    }
}
