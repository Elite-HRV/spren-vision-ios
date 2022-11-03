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
        case faq1
        case faq2
        case faq3
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
        case .faq1: faqScreen1
        case .faq2: faqScreen2
        case .faq3: faqScreen3
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
                            .foregroundColor(.sprenUISecondaryColor)
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
            
            if results.readiness == nil {
                TopResultCard(value: results.hrvScore,
                           type: .hrvScore)
                .onTapGesture { transition(to: .hrvScoreInfo) }
                TopResultCard(value: results.hr,
                           type: .hr)
                .onTapGesture { transition(to: .hrInfo) }
                TopResultCard(value: results.breathingRate,
                           type: .breathingRate)
                .onTapGesture { transition(to: .respiratoryRateInfo) }
            } else {
                HStack(spacing: 20) {
                    VStack(spacing: 20) {
                        SimpleResultCard(title: "HRV Score", value: results.hrvScore, label: "", onTap: { transition(to: .hrvScoreInfo) })
                        SimpleResultCard(title: "Heart Rate", value: results.hr, label: "bpm", onTap: { transition(to: .hrInfo) })
                        Spacer()
                    }
                    VStack(spacing: 20) {
                        SimpleResultCard(title: "Respiration", value: results.breathingRate, label: "rpm", onTap: { transition(to: .respiratoryRateInfo) })
                        Spacer()
                    }
                }
                .sprenUIPadding([.leading, .top, .trailing])
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
                    .onTapGesture {
                        transition(to: .faq1)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("How do I get the best results?")
                            .font(.sprenParagraph)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .onTapGesture {
                        transition(to: .faq2)
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("How often should I measure?")
                            .font(.sprenParagraph)
                        Spacer()
                        Image(systemName: "chevron.right")
                    }
                    .onTapGesture {
                        transition(to: .faq3)
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
                   type: .recovery,
                   results: results,
                   onBackButtonTap: { transition(to: .results) })
    }
    
    var ansBalanceInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "ANS Balance",
                   title: "ANS Balance",
                   paragraph1: "The autonomic nervous system (ANS) controls almost all of the body’s “automatic” processes. It regulates bodily functions such as heart rate, blood sugar, blood pressure, temperature, energy, digestion, sexual function, tissue repair, and more.",
                   illustration: "ANSBalance",
                   paragraph2: "The ANS Balance indicates the relative balance between thethe SNS and PSNS, thus indicating the balance between recovery and physiological stress (both physical and mental).\n\nKnowing the relative balance of the ANS helps you better understand the current state of your body and determine the best course of action towards reaching your goals without working against yourself.",
                   type: .ansBalance,
                   results: results,
                   onBackButtonTap: { transition(to: .results) })
    }
    
    var hrvScoreInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "HRV Score",
                   title: "What is HRV?",
                   paragraph1: "Your HRV Score is a 1-100 score that indicates your stress levels, recovery status, and general well-being.\n\nUnlike basic heart rate (HR) that counts the number of heartbeats per minute, heart rate variability (HRV) looks much closer at the subtle variations between heartbeats that originate from your nervous system.\n\nHRV is considered the best, non-invasive measure of your Autonomic Nervous System and reveals how your body responds to exercise, illness, treatment, recovery, inflammation, stress, mental health, and lifestyle choices you make.\n\nA higher HRV Score generally indicates better health and fitness and lower stress, as well as a younger biological age.",
                   illustration: "",
                   paragraph2: "",
                   type: .hrvScore,
                   results: results,
                   onBackButtonTap: { transition(to: .results) })
    }
    
    var hrInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "Heart Rate",
                   title: "What is resting heart rate?",
                   paragraph1: "Resting heart rate (RHR) is a measure of your average number of heart beats per minute (bpm) while at rest. 60-100 bpm is considered normal for healthy adults. Highly trained athletes can have resting heart rates as low as 40 bpm.\n\nResting heart rate is a useful metric for monitoring your fitness level and overall health. Generally speaking, a lower resting heart rate indicates a stronger and healthier heart muscle. People with lower resting heart rates typically have better cardiorespiratory fitness and tend to live longer.\n\nA short-term increase in resting heart rate can indicate physiological stress from things like exercise, stress and anxiety, sleep deprivation, illness onset, etc.\n\nTo get an accurate resting heart rate measurement, ideally measure while in an inactive state such as seated, standing, or lying down without moving.",
                   illustration: "",
                   paragraph2: "",
                   type: .hr,
                   results: results,
                   onBackButtonTap: { transition(to: .results) })
    }
    
    var respiratoryRateInfoScreen: InfoScreen {
        InfoScreen(navBarTitle: "Respiratory Rate",
                   title: "What is resting respiratory rate?",
                   paragraph1: "Respiratory rate, or breathing rate, is the number of respirations (i.e. breaths) you take per minute while at rest. The normal respiration rate for an adult at rest is 12 to 20  breaths per minute. A respiration rate under 12 or over 20 breaths per minute while resting is considered abnormal.\n\nResting respiration rate can indicate general cardiorespiratory fitness. Acute changes in resting respiratory rate can indicate poor rest and recovery or the onset of illness.\n\nYour respiratory rate is calculated via raw heart rate data by taking advantage of Respiratory Sinus Arrhythmia, a normal phenomenom where the heart rate varies with respiration.",
                   illustration: "",
                   paragraph2: "",
                   type: .breathingRate,
                   results: results,
                   onBackButtonTap: { transition(to: .results) })
    }
    
    var faqScreen1: FAQScreen {
        FAQScreen(content: [
            "What is HRV?",
            """
            Heart rate variability (HRV) is the subtle variations between heartbeats that originate from your nervous system and indicates your stress levels, recovery status, and general well-being.
            
            HRV is considered the best, non-invasive measure of your Autonomic Nervous System (ANS), which controls almost all of the body’s “automatic” processes such as heart rate, blood pressure, temperature, digestion, sexual function, tissue repair, and more. The opposing branches of the ANS modulate your body’s “fight or flight” stress response and “rest and digest” recovery activities.
            """,
            "Why does it matter?",
            """
            A higher HRV Score generally indicates better health, a younger biological age, and better aerobic fitness. Tracking your HRV over time can show when you are improving or not.
            
            HRV is great at measuring baseline physiological stress. Regularly measuring HRV and related insights such as Recovery can reveal how your body responds to things like exercise, stress, nutrition, work, and more so you can start to learn what factors most affect you.
            
            Your Recovery score can help you understand when your body is ready to perform and when you need to focus on rest and recovery in order to prevent over-training or injury.
            """,
        ],
        fonts: [
            .sprenTitle,
            .sprenParagraph,
            .sprenTitle,
            .sprenParagraph
        ],
        onBackButtonTap: { transition(to: .results) })
    }
    
    var faqScreen2: FAQScreen {
        FAQScreen(content: [
            "How do I get the most accurate Recovery results?",
            """
            Consistency is key!
            
            When measured consistently, the Recovery Score (based on HRV) can provide a gauge for how your body is responding to (or recovering from) things like exercise, stress, nutrition, work and more.  Because HRV can be influenced by the day’s stressors and normal hormonal and circadian rhythms, consistency in measurement practice can reduce the effects of these confounding factors to provide better results and guidance.
            """,
            "For the best results:",
            """
            1. Do your measurements in the same position every time such as sitting or lying down
            2. Try to do your measurements around the same time of day, ideally within 30 minutes of waking in the morning prior to exercise or caffeine consumption.
            3. Try to do measurements at least 4 times per week so the algorithms can generate an accurate picture of your baseline.
            
            •  Refrain from strenuous activity for at least 15 minutes prior to your measurement
            •  Sit calmly for at least one minute before your measurement
            •  Take 6 deep and slow breaths before starting your reading to calm your nervous system and lower your heart rate to a rested state
            •  Breath naturally during your measurement
            """
        ],
        fonts: [
            .sprenTitle,
            .sprenParagraph,
            .sprenParagraphBold,
            .sprenParagraph,
            .sprenParagraph
        ],
        onBackButtonTap: { transition(to: .results) })
    }
    
    var faqScreen3: FAQScreen {
        FAQScreen(content: [
            "How often should I measure?",
            """
            For the most accurate Recovery results and personalized guidance, we recommend doing a measurement at least four (4) days per week. This allows us to adequately establish what “normal” looks like for you and better alert you when your HRV patterns show your body is under-recovered.
            
            Our algorithms need at least 2 days to start establishing your baseline patterns and will continue to build your baseline over a 2-week period. Then your baseline will continually update over time as your HRV, health, and fitness levels change.
            
            Consistency in how you do you measurement is important. Because HRV can be influenced by the day’s stressors and normal hormonal and circadian rhythms, consistency in measurement practice can reduce the effects of these confounding factors. Try to do your measurement in the same position every day (i.e. sitting or lying down) and try to do it around the same time of day, ideally within 30 minutes of waking in the morning prior to exercise or caffeine consumption.
            """
        ],
        fonts: [
            .sprenTitle,
            .sprenParagraph,
        ],
        onBackButtonTap: { transition(to: .results) })
    }
    
}


struct ResultsScreen_Previews: PreviewProvider {
    static var previews: some View {
//        let previewDevices = [
            // problem devices
//            "iPhone SE (1st generation)",
//            "iPhone 6s",
//            "iPhone 7",
//            "iPhone 8",
//            "iPhone SE (2nd generation)",
//            "iPhone 11",
//            "iPhone 13 mini",
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
//        ]
        
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
                                                                   breathingRate: 11,
                                                                   readiness: nil,
                                                                   ansBalance: 2,
                                                                signalQuality: 2))
    }
}
