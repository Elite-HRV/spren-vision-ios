//
//  InfoCard.swift
//  
//
//  Created by Fernando on 9/28/22.
//

import SwiftUI

struct InfoCard: View {
    @Environment(\.colorScheme) var colorScheme
    
    var title: String
    var text: String
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text(title).font(.sprenSubtitle)
                    
                    Spacer()
                }.padding(.bottom, 1)
                Text(text).font(.sprenLabel)
                
            }
            .sprenUIPadding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)
        }
        .sprenUIPadding()
    }
}

struct InfoCard_Previews: PreviewProvider {
    static var previews: some View {
        InfoCard(title: "Abnormally Low", text: "A resting respiratory rate below 12 breaths per minute in adults is called bradypnea. Bradypnea can occur when you do slow, deep, and controlled breathing for relaxation and breathing exercises and is not a concern then unless you feel lightheaded, dizzy, or shortness of breath.\nHowever, if you are at rest and breathing normally, bradypnea for too long can be concerning because it can lead to hypoxemia (i.e. low blood oxygen), respiratory acidosis, or complete respiratory failure. Some potential causes for bradypnea while in a rested state include:\n • Opioid drugs\n • Sedatives\n • Hormone imbalances (e.g. untreated hypothyroidism)\n • Toxins (e.g. carbon monoxide, chemicals that affect the central nervous system and cardiovascular system)\n • Head injury\n • Lung disorders\n • Electrolyte imbalance\n\nIf you have an abnormal respiratory rate, seek guidance from your doctor or other qualified health professional with questions or concerns regarding your health or a potential medical condition.")
    }
}
