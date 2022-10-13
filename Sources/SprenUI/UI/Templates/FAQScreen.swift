//
//  FAQScreen.swift
//  
//
//  Created by Keith Carolus on 10/13/22.
//

import SwiftUI

struct FAQScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let content: [String]
    let fonts: [Font]
    let onBackButtonTap: () -> Void
    
    var body: some View {
        ScrollView {
            
            // heading
            HStack {
                Button(action: onBackButtonTap, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        .sprenUIPadding(.leading)
                })
                .sprenUIPadding()
                Spacer()
            }
            .background(colorScheme == .light ? Color.white : Color.black)
            
            
            VStack(alignment: .leading, spacing: 0) {
                ForEach(0..<content.count, id: \.self) { i in
                    Text(content[i])
                        .font(fonts[i])
                        .sprenUIPadding()
                }
            }
            .background(colorScheme == .light ? Color.offWhite : Color.offBlack)
        }
        
    }

}

struct FAQScreen_Previews: PreviewProvider {
    static var previews: some View {
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
        onBackButtonTap: {})
        
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
        onBackButtonTap: {})
        
        
        
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
        onBackButtonTap: {})
    }
}
