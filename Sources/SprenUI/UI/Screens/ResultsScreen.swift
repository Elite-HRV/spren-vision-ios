//
//  NewResultsScreen.swift
//  
//
//  Created by Keith Carolus on 9/22/22.
//

import SwiftUI

struct ResultsScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let onDoneButtonTap: (_ results: Results) -> Void
    let results: Results
    
    var body: some View {
        
        ScrollView {
            
            // heading
            ZStack {
                Text("Results")
                    .font(.sprenButton)
                
                HStack {
                    Button(action: {
                        onDoneButtonTap(results)
                    }, label: {
                        Text("Done")
                            .font(.sprenButton)
                            .foregroundColor(.sprenPink)
                    })
                    .padding(Autoscale.padding)
                    Spacer()
                }
            }
            .background(colorScheme == .light ? Color.white : Color.black)
            
            // readiness
            if let readiness = results.readiness {
                ReadinessResult(readiness: Int(readiness.rounded(.toNearestOrEven)))
            } else {
                ReadinessResult(readiness: nil)
            }
            
            // results cards
            HStack(spacing: 20) {
                VStack(spacing: 20) {
                    ResultCard(title: "HRV Score", value: results.hrvScore, label: "")
                    ResultCard(title: "Heart Rate", value: results.hr, label: "bpm")
                    Spacer()
                }
                VStack(spacing: 20) {
                    ResultCard(title: "Respiration", value: results.breathingRate, label: "rpm")
                    Spacer()
                }
            }
            .padding([.leading, .top, .trailing])
            
            // FAQ
            VStack {
                VStack {
                    HStack {
                        Text("FAQ")
                            .font(.sprenAlertTitle)
                            .padding(.bottom)
                        Spacer()
                    }
                    
                    HStack {
                        Text("What is HRV and why does it matter?")
                            .font(.sprenParagraph)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Divider()
                    HStack {
                        Text("What does my score mean?")
                            .font(.sprenParagraph)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    Divider()
                    HStack {
                        Text("How often should I measure?")
                            .font(.sprenParagraph)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                }
                .padding()
                .background(colorScheme == .light ? Color.white : Color.black)
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.2), radius: 8)
            }
            .padding()
            
        }
        .background(colorScheme == .light ? Color.offWhite : Color.offBlack)

    }
}

struct ResultsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ResultsScreen(onDoneButtonTap: { _ in }, results: .init(guid: "",
                                                                   hr: 58.9,
                                                                   hrvScore: 63.1,
                                                                   rmssd: 0.3,
                                                                   breathingRate: 12,
                                                                   readiness: 8,
                                                                   ansBalance: 3,
                                                                   signalQuality: 2))
            .loadCustomFonts()
    }
}
