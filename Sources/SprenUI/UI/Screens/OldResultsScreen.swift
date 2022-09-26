//
//  ResultsScreen.swift
//  SprenUI
//
//  Created by Keith Carolus on 2/3/22.
//

import SwiftUI

struct OldResultsScreen: View {
    
    @Environment(\.openURL) var openURL
    
    let onDoneButtonTap: (_ results: Results) -> Void
    let results: Results
    
    var body: some View {
        ScrollView {
            
            VStack {
                HStack {
                    Button(action: {
                        onDoneButtonTap(results)
                    }, label: {
                        Text("Done")
                            .font(.sprenProgress)
                            .foregroundColor(.sprenPurple)
                    })
                    .sprenUIPadding()
                    Spacer()
                }
                
                Text("Congrats!")
                    .font(.sprenTitle)
                    .sprenUIPadding(.bottom, factor: 3)
                
                Text("You just completed a heart rate variability (HRV) reading using your smartphone camera.")
                    .font(.sprenParagraph)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .sprenUIPadding([.leading, .trailing, .bottom])
                
                HStack {
                    VStack {
                        Text(String(format: "%.0f", results.hrvScore.rounded(.toNearestOrEven)))
                            .font(.sprenNumber)
                        Text("HRV Score")
                            .font(.sprenParagraph)
                    }
                    Image("HeartSignal", bundle: .module)
                    VStack {
                        Text(String(format: "%.0f", results.hr.rounded(.toNearestOrEven)))
                            .font(.sprenNumber)
                        Text("Heart Rate")
                            .font(.sprenParagraph)
                    }
                }
                .sprenUIPadding()
                
                VStack {
                    Text("Population Comparison")
                        .font(.sprenAlertTitle)
                        .sprenUIPadding()
                    
                    Text("Compare yourself against the average HRV range of Spren's global population.*")
                        .font(.sprenParagraph)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.gray)
                        .sprenUIPadding([.leading, .trailing, .bottom])
                    
                    RangeBar(value: Int(results.hrvScore.rounded(.toNearestOrEven)))
                        .sprenUIPadding(.bottom, factor: 2)
                }
                .background(Color.gray.opacity(0.1))
                .sprenUIPadding()
                
                Group {
                
                    Text("Unlock biomarkers and insights for your users!")
                        .font(.sprenTitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .sprenUIPadding()
                                        
                    Text("How are brands using Spren?")
                        .font(.sprenSubtitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 1)
                    
                    Text(" •  Personalize training programs\n •  Measure stress and recovery\n •  Quantify well-being outcomes")
                        .font(.sprenParagraph)
                        .fixedSize(horizontal: false, vertical: true)
                        .sprenUIPadding(.bottom)
                    
                    Text("Tap below for examples of how you can elevate your offering simply by integrating Spren into your app.")
                        .font(.sprenSubtitle)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .sprenUIPadding()
                    
                    SprenButton(title: "See how Spren can help", action: {
                        if let url = URL(string: "https://spren.app.link/e/see-more-spren-demo") {
                            openURL(url)
                        }
                    })
                    .sprenUIPadding()
                    
                    Spacer()
                    Text("* For investigational use only. These numbers are estimates and not a substitute for the judgment of a health care professional. They are intended to improve awareness of general fitness and wellness.")
                        .font(.disclaimer)
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.sprenGray)
                        .sprenUIPadding([.top,.leading,.trailing])
                    Image("PoweredBySpren", bundle: .module)
                        .sprenUIPadding()
                    
                }
                
            }
            
        }
    }
}

struct OldResultsScreen_Previews: PreviewProvider {
    static var previews: some View {
        OldResultsScreen(onDoneButtonTap: { _ in }, results: .init(guid: "",
                                                                hr: 58.9,
                                                                hrvScore: 63.1,
                                                                rmssd: 0.3,
                                                                breathingRate: 12,
                                                                readiness: 8,
                                                                ansBalance: 3,
                                                                signalQuality: 2))
    }
}
