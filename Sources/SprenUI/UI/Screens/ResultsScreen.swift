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
    
    enum ResultsNavTag {
        case results
        case recoveryInfo
        case ansBalanceInfo
        case hrvScoreInfo
        case hrInfo
        case respiratoryRateInfo
    }
    
    @State var navTag: ResultsNavTag = .results
    
    var body: some View {
        switch navTag {
        case .results: resultsScreen
        case .recoveryInfo: recoveryInfoScreen
        case .ansBalanceInfo: ansBalanceInfoScreen
        case .hrvScoreInfo: hrvScoreInfoScreen
        case .hrInfo: hrInfoScreen
        case .respiratoryRateInfo: respiratoryRateInfoScreen
        }
    }
    
    func transition(to navTag: ResultsNavTag) {
        DispatchQueue.main.async {
            withAnimation {
                self.navTag = navTag
            }
        }
    }
    
    var resultsScreen: some View {
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
                    .sprenUIPadding()
                    Spacer()
                }
            }
            .background(colorScheme == .light ? Color.white : Color.black)
            
            // readiness
            if let readiness = results.readiness {
                ReadinessResult(readiness: Int(readiness.rounded(.toNearestOrEven)), onInfoButtonTap: { transition(to: .recoveryInfo) })
            } else {
                ReadinessResult(readiness: nil, onInfoButtonTap: { transition(to: .recoveryInfo) })
            }
            
            // ANS balance
            if let ansBalance = results.ansBalance, let intANSBalance = Int(ansBalance) {
                ANSBalanceResult(ansBalance: intANSBalance, onInfoButtonTap: { transition(to: .ansBalanceInfo) })
            }
            
            // results cards
            if let readiness = results.readiness {
                HStack(spacing: 20) {
                    VStack(spacing: 20) {
                        ResultCard(title: "HRV Score", value: results.hrvScore, label: "", onTap: { transition(to: .hrvScoreInfo) })
                        ResultCard(title: "Heart Rate", value: results.hr, label: "bpm", onTap: { transition(to: .hrInfo) })
                        Spacer()
                    }
                    VStack(spacing: 20) {
                        ResultCard(title: "Respiration", value: results.breathingRate, label: "rpm", onTap: { transition(to: .respiratoryRateInfo) })
                        Spacer()
                    }
                }
                .sprenUIPadding([.leading, .top, .trailing])
            }else{
                ScoreCard(results: results, type: "hrvScore")
                ScoreCard(results: results, type: "hr")
                ScoreCard(results: results, type: "breathingRate")
            }
            
            // FAQ
            VStack {
                VStack {
                    HStack {
                        Text("FAQ")
                            .font(.sprenAlertTitle)
                            .sprenUIPadding(.bottom)
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
                .sprenUIPadding()
                .background(colorScheme == .light ? Color.white : Color.black)
                .cornerRadius(16)
                .shadow(color: .gray.opacity(0.2), radius: 8)
            }
            .sprenUIPadding()
            
        }
        .background(colorScheme == .light ? Color.offWhite : Color.offBlack)
    }
    
}

extension ResultsScreen {
    
    var recoveryInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "Recovery",
                   title: "Recovery",
                   paragraph1: "Your Recovery Score is a personalized daily score that quantifies how recovered you are and how ready you are to take on the day.\n\nThis 1-10 score uses key heart rate and heart rate variability (HRV) metrics to learn your personal patterns and provide insight into how your body is adapting to things like exercise, stress, nutrition, work, and more. It helps you understand when your body is ready to perform and when you need to focus on rest and recovery.",
                   illustration: "Recovery",
                   paragraph2: "",
                   onBackButtonTap: { navTag = .results })
    }
    
    var ansBalanceInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "ANS Balance",
                   title: "ANS Balance",
                   paragraph1: "The autonomic nervous system (ANS) controls almost all of the body’s “automatic” processes. It regulates bodily functions such as heart rate, blood sugar, blood pressure, temperature, energy, digestion, sexual function, tissue repair, and more.",
                   illustration: "ANSBalance",
                   paragraph2: "The ANS Balance indicates the relative balance between thethe SNS and PSNS, thus indicating the balance between recovery and physiological stress (both physical and mental).\n\nKnowing the relative balance of the ANS helps you better understand the current state of your body and determine the best course of action towards reaching your goals without working against yourself.",
                   onBackButtonTap: { navTag = .results })
    }
    
    var hrvScoreInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "HRV Score",
                   title: "What is HRV?",
                   paragraph1: "Your HRV Score is a 1-100 score that indicates your stress levels, recovery status, and general well-being.\n\nUnlike basic heart rate (HR) that counts the number of heartbeats per minute, heart rate variability (HRV) looks much closer at the subtle variations between heartbeats that originate from your nervous system.\n\nHRV is considered the best, non-invasive measure of your Autonomic Nervous System and reveals how your body responds to exercise, illness, treatment, recovery, inflammation, stress, mental health, and lifestyle choices you make.\n\nA higher HRV Score generally indicates better health and fitness and lower stress, as well as a younger biological age.",
                   illustration: "",
                   paragraph2: "",
                   onBackButtonTap: { navTag = .results })
    }
    
    var hrInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "Heart Rate",
                   title: "What is resting heart rate?",
                   paragraph1: "Resting heart rate (RHR) is a measure of your average number of heart beats per minute (bpm) while at rest. 60-100 bpm is considered normal for healthy adults. Highly trained athletes can have resting heart rates as low as 40 bpm.\n\nResting heart rate is a useful metric for monitoring your fitness level and overall health. Generally speaking, a lower resting heart rate indicates a stronger and healthier heart muscle. People with lower resting heart rates typically have better cardiorespiratory fitness and tend to live longer.\n\nA short-term increase in resting heart rate can indicate physiological stress from things like exercise, stress and anxiety, sleep deprivation, illness onset, etc.\n\nTo get an accurate resting heart rate measurement, ideally measure while in an inactive state such as seated, standing, or lying down without moving.",
                   illustration: "",
                   paragraph2: "",
                   onBackButtonTap: { navTag = .results })
    }
    
    var respiratoryRateInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "Respiratory Rate",
                   title: "What is resting respiratory rate?",
                   paragraph1: "Respiratory rate, or breathing rate, is the number of respirations (i.e. breaths) you take per minute while at rest. The normal respiration rate for an adult at rest is 12 to 20  breaths per minute. A respiration rate under 12 or over 20 breaths per minute while resting is considered abnormal.\n\nResting respiration rate can indicate general cardiorespiratory fitness. Acute changes in resting respiratory rate can indicate poor rest and recovery or the onset of illness.\n\nYour respiratory rate is calculated via raw heart rate data by taking advantage of Respiratory Sinus Arrhythmia, a normal phenomenom where the heart rate varies with respiration.",
                   illustration: "",
                   paragraph2: "",
                   onBackButtonTap: { navTag = .results })
    }
    
}


struct ResultsScreen_Previews: PreviewProvider {
    static var previews: some View {
        let previewDevices = [
            // problem devices
//            "iPhone SE (1st generation)",
//            "iPhone 6s",
//            "iPhone 7",
//            "iPhone 8",
            "iPhone SE (2nd generation)",
            "iPhone 11",
            "iPhone 13 mini",
            
//            "iPhone SE (1st generation)",
//            "iPhone 6s",
//            "iPhone 6s Plus",
//            "iPhone 7",
//            "iPhone 7 Plus",
//            "iPhone 8",
//            "iPhone 8 Plus",
//            "iPhone X",
//            "iPhone XR",
//            "iPhone XS",
//            "iPhone XS Max",
//            "iPhone SE (2nd generation)",
//            "iPhone 11",
//            "iPhone 11 Pro",
//            "iPhone 11 Pro Max",
//            "iPhone 12 mini",
//            "iPhone 12",
//            "iPhone 12 Pro",
//            "iPhone 12 Pro Max",
//            "iPhone 13 mini",
//            "iPhone 13",
//            "iPhone 13 Pro",
//            "iPhone 13 Pro Max",
        ]
        
//        ForEach(previewDevices, id: \.self) { device -> AnyView in
//            AnyView(
//                ResultsScreen(onDoneButtonTap: { _ in }, results: .init(guid: "",
//                                                                           hr: 58.9,
//                                                                           hrvScore: 63.1,
//                                                                           rmssd: 0.3,
//                                                                           breathingRate: 12,
//                                                                           readiness: 8,
//                                                                           ansBalance: 5,
//                                                                           signalQuality: 2))
//                    .previewDevice(PreviewDevice.init(rawValue: device))
//            )
//        }
        
        ResultsScreen(onDoneButtonTap: { _ in }, results: .init(guid: "",
                                                                   hr: 58.9,
                                                                   hrvScore: 63.1,
                                                                   rmssd: 0.3,
                                                                   breathingRate: 12,
                                                                   readiness: nil,
                                                                   ansBalance: nil,
                                                                   signalQuality: 2))
        
    }
}
