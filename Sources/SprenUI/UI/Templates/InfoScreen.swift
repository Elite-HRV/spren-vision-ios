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
    let type: `Type`
    let results: Results
    
    let age = SprenUI.config.userBirthdate?.age
    let gender = SprenUI.config.userGender
    
    let onBackButtonTap: () -> Void
    
    let illustrationSize = Autoscale.scaleFactor * 300
    
    enum `Type` {
        case recovery
        case ansBalance
        case hrvScore
        case hr
        case breathingRate
    }
    
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
                            .sprenUIPadding(.leading)
                    })
                    .sprenUIPadding()
                    Spacer()
                }
            }
            .background(colorScheme == .light ? Color.white : Color.black)
            
            VStack(alignment: .leading, spacing: 0) {
                VStack {
                    if type == .hrvScore {
                        DemographicHRVCard(value: results.hrvScore)
                    }
                    if type == .hr {
                        DemographicHRCard(value: results.hr)
                    }
                    if type == .breathingRate {
                        DemographicRRCard(breathingRate: results.breathingRate)
                    }
                }

                // title
                HStack {
                    Text(title)
                        .font(.sprenAlertTitle)
                    Spacer()
                }
                .sprenUIPadding([.leading, .bottom, .trailing])
                
                // paragraph 1
                Text(paragraph1)
                    .font(.sprenParagraph)
                    .sprenUIPadding([.leading, .bottom, .trailing])
                
                // illustration
                if(illustration.count > 0){
                    HStack {
                        Spacer()
                        Image(illustration, bundle: .module)
                            .resizable()
                            .frame(width: illustrationSize,
                                   height: illustrationSize)
                            .sprenUIPadding()
                        Spacer()
                    }
                }
                
                // paragraph 2
                if(paragraph2.count > 0){
                    Text(paragraph2)
                        .font(.sprenParagraph)
                        .sprenUIPadding()
                }
                
                if (type == .hrvScore) {
                    InfoImprovements(
                        title: "How do I improve my HRV?",
                        text: "Healthy behaviors can increase your HRV. Here are some proven ways to increase your HRV:",
                        infoImprovementVMs: [InfoImprovementViewModel(icon: "Cardio", title: "Stay active", text: "Avoid being sedentary and exercise appropriately; athletes should avoid overtraining."), InfoImprovementViewModel(icon: "Sleep", title: "Sleep well and consistently", text: "Consistent, quality sleep is key to recovering from daily stressors."), InfoImprovementViewModel(icon: "Food", title: "Eat well", text: "Reduce inflammatory foods and alcohol and prioritize nutrient rich foods; avoid large meals close to bedtime."), InfoImprovementViewModel(icon: "Bottle", title: "Hydrate", text: "Hydration is important for maintaining a healthy blood volume needed to deliver oxygen and nutrients to your body."), InfoImprovementViewModel(icon: "Bottle", title: "Hydrate", text: "Hydration is important for maintaining a healthy blood volume needed to deliver oxygen and nutrients to your body."), InfoImprovementViewModel(icon: "Stress", title: "Better manage stress", text: "Listen to your body and prioritize recovery activities when you have increased stress."), InfoImprovementViewModel(icon: "Breathing", title: "Intentional breathing", text: "Doing regular intentional breathing practices with slow, controlled breathing techniques can reduce stress and improve HRV."), InfoImprovementViewModel(icon: "Sun", title: "Natural light exposure", text: "Early morning and evening sunlight can help regulate your circadium rhythm and improve vitamin D production.")]
                    )
                }
                
                if (type == .hr) {
                    InfoImprovements(
                        title: "How to improve resting heart rate",
                        text: "Healthy behaviors can lower your resting heart rate and improve your health and longevity. Here are some proven ways to lower your resting heart rate:",
                        infoImprovementVMs: [InfoImprovementViewModel(icon: "Cardio", title: "Stay active", text: "Avoid being sedentary and exercise appropriately to maintain a stronger heart muscle. The American Heart Association recommends at least 150 minutes per week of moderate-intensity aerobic activity or 75 minutes per week of vigorous activity."),InfoImprovementViewModel(icon: "Weight", title: "Maintain a healthy weight", text: "Excess fat and not enough muscle mass force your heart to work harder to deliver blood to your body. Maintaining a healthy weight with good nutrition and regular exercise gives your heart a break."),InfoImprovementViewModel(icon: "Bottle", title: "Stay hydrated", text: "Hydration is important for maintaining a healthy blood volume needed to deliver oxygen and nutrients to your body. Dehydration can cause your blood to thicken, which makes your heart work harder."),InfoImprovementViewModel(icon: "Sleep", title: "Sleep well and consistently", text: "Your heart rate lowers while you are sleeping. Consistent, quality sleep gives your heart a needed break to recover from the day’s stressors."),InfoImprovementViewModel(icon: "Stress", title: "Better manage stress", text: "Anxiety and stress can elevate your heart rate. Listen to your body and practice mindfulness and breathing exercises to combat stress."),InfoImprovementViewModel(icon: "noSmoking", title: "Avoid caffeine and nicotine", text: "Caffeine and cigarettes can increase your heart rate and cutting back can lower your resting heart rate.")]
                    )
                }
                
                if (type == .breathingRate && results.breathingRate < 12) {
                    InfoCard(title: "Abnormally Low", text: "A resting respiratory rate below 12 breaths per minute in adults is called bradypnea. Bradypnea can occur when you do slow, deep, and controlled breathing for relaxation and breathing exercises and is not a concern then unless you feel lightheaded, dizzy, or shortness of breath.\nHowever, if you are at rest and breathing normally, bradypnea for too long can be concerning because it can lead to hypoxemia (i.e. low blood oxygen), respiratory acidosis, or complete respiratory failure. Some potential causes for bradypnea while in a rested state include:\n • Opioid drugs\n • Sedatives\n • Hormone imbalances (e.g. untreated hypothyroidism)\n • Toxins (e.g. carbon monoxide, chemicals that affect the central nervous system and cardiovascular system)\n • Head injury\n • Lung disorders\n • Electrolyte imbalance\n\nIf you have an abnormal respiratory rate, seek guidance from your doctor or other qualified health professional with questions or concerns regarding your health or a potential medical condition.")
                }
                
                if (type == .breathingRate && results.breathingRate > 20) {
                    InfoCard(title: "Abnormally High", text: "A resting respiratory rate above 20 breaths per minute in adults is called tachypnea. Tachypnea is rapid, shallow breathing that results from a lack of oxygen or too much carbon dioxide in the body. Tachypnea is normal during exercise or exertion but can be concerning when it occurs at rest. Tachypnea in a rested state can be caused by:\n • Anxiety or panic attack\n • Fever or virus\n • Lung-related conditions\n • Overheating from heatstroke\n • Sepsis\n • High acid levels in the blood related to health conditions such as diabetic ketoacidosis\n • Heart-related conditions such as heart failure and anemia\n • Certain drugs such as aspirin, stimulants, and marijuana\nIf tachypnea occurs without any other obvious symptoms or conditions, then it could be related to metabolic imbalances or central nervous system conditions.\n\nIf you have an abnormal respiratory rate, seek guidance from your doctor or other qualified health professional with questions or concerns regarding your health or a potential medical condition.")
                }
            }
            .sprenUIPadding()
            
        }
        .background(colorScheme == .light ? Color.offWhite : Color.offBlack)
    }
    
}

struct InfoScreen_Previews: PreviewProvider {
    static var previews: some View {
        InfoScreen(navBarTitle: "HRV Score",
                   title: "What is HRV?",
                   paragraph1: "Your HRV Score is a 1-100 score that indicates your stress levels, recovery status, and general well-being.\n\nUnlike basic heart rate (HR) that counts the number of heartbeats per minute, heart rate variability (HRV) looks much closer at the subtle variations between heartbeats that originate from your nervous system.\n\nHRV is considered the best, non-invasive measure of your Autonomic Nervous System and reveals how your body responds to exercise, illness, treatment, recovery, inflammation, stress, mental health, and lifestyle choices you make.\n\nA higher HRV Score generally indicates better health and fitness and lower stress, as well as a younger biological age.",
                   illustration: "",
                   paragraph2: "",
                   type: .hrvScore,
                   results: Results(guid: "",
                                    hr: 58.9,
                                    hrvScore: 63.1,
                                    rmssd: 0.3,
                                    breathingRate: 12,
                                    readiness: 8,
                                    ansBalance: 2,
                                    signalQuality: 2),
                   onBackButtonTap: {})
        
        InfoScreen(navBarTitle: "Heart Rate",
                   title: "What is resting heart rate?",
                   paragraph1: "Resting heart rate (RHR) is a measure of your average number of heart beats per minute (bpm) while at rest. 60-100 bpm is considered normal for healthy adults. Highly trained athletes can have resting heart rates as low as 40 bpm.\n\nResting heart rate is a useful metric for monitoring your fitness level and overall health. Generally speaking, a lower resting heart rate indicates a stronger and healthier heart muscle. People with lower resting heart rates typically have better cardiorespiratory fitness and tend to live longer.\n\nA short-term increase in resting heart rate can indicate physiological stress from things like exercise, stress and anxiety, sleep deprivation, illness onset, etc.\n\nTo get an accurate resting heart rate measurement, ideally measure while in an inactive state such as seated, standing, or lying down without moving.",
                   illustration: "",
                   paragraph2: "",
                   type: .hr,
                   results: Results(guid: "",
                                    hr: 58.9,
                                    hrvScore: 63.1,
                                    rmssd: 0.3,
                                    breathingRate: 12,
                                    readiness: 8,
                                    ansBalance: 2,
                                    signalQuality: 2),
                   onBackButtonTap: {})
        
        InfoScreen(navBarTitle: "Respiratory Rate",
                   title: "What is resting respiratory rate?",
                   paragraph1: "Respiratory rate, or breathing rate, is the number of respirations (i.e. breaths) you take per minute while at rest. The normal respiration rate for an adult at rest is 12 to 20  breaths per minute. A respiration rate under 12 or over 20 breaths per minute while resting is considered abnormal.\n\nResting respiration rate can indicate general cardiorespiratory fitness. Acute changes in resting respiratory rate can indicate poor rest and recovery or the onset of illness.\n\nYour respiratory rate is calculated via raw heart rate data by taking advantage of Respiratory Sinus Arrhythmia, a normal phenomenom where the heart rate varies with respiration.",
                   illustration: "",
                   paragraph2: "",
                   type: .breathingRate,
                   results: Results(guid: "",
                                  hr: 58.9,
                                  hrvScore: 63.1,
                                  rmssd: 0.3,
                                  breathingRate: 9,
                                  readiness: 8,
                                  ansBalance: 2,
                                  signalQuality: 2),
                   onBackButtonTap: {})
        
        
            
        
        
        InfoScreen(navBarTitle: "Recovery",
                   title: "Recovery",
                   paragraph1: "Your Recovery Score is a personalized daily score that quantifies how recovered you are and how ready you are to take on the day.\n\nThis 1-10 score uses key heart rate and heart rate variability (HRV) metrics to learn your personal patterns and provide insight into how your body is adapting to things like exercise, stress, nutrition, work, and more. It helps you understand when your body is ready to perform and when you need to focus on rest and recovery.",
                   illustration: "Recovery",
                   paragraph2: "",
                   type: .recovery,
                   results: Results(guid: "",
                                    hr: 58.9,
                                    hrvScore: 63.1,
                                    rmssd: 0.3,
                                    breathingRate: 12,
                                    readiness: 8,
                                    ansBalance: 2,
                                    signalQuality: 2),
                   onBackButtonTap: {})
        
        InfoScreen(navBarTitle: "ANS Balance",
                   title: "ANS Balance",
                   paragraph1: "The autonomic nervous system (ANS) controls almost all of the body’s “automatic” processes. It regulates bodily functions such as heart rate, blood sugar, blood pressure, temperature, energy, digestion, sexual function, tissue repair, and more.",
                   illustration: "ANSBalance",
                   paragraph2: "The ANS Balance indicates the relative balance between thethe SNS and PSNS, thus indicating the balance between recovery and physiological stress (both physical and mental).\n\nKnowing the relative balance of the ANS helps you better understand the current state of your body and determine the best course of action towards reaching your goals without working against yourself.",
                   type: .recovery,
                   results: Results(guid: "",
                                    hr: 58.9,
                                    hrvScore: 63.1,
                                    rmssd: 0.3,
                                    breathingRate: 12,
                                    readiness: 8,
                                    ansBalance: 2,
                                    signalQuality: 2),
                   onBackButtonTap: {})
    }
}
