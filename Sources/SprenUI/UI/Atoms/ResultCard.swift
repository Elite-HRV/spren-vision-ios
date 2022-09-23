//
//  ResultCard.swift
//  
//
//  Created by Keith Carolus on 9/23/22.
//

import SwiftUI

struct ResultCard: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let value: Double
    let label: String
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.sprenParagraph)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .padding(.bottom)
            HStack {
                Text("\(String(format: "%.0f", value))")
                    .font(.sprenTitle)
                Text(label)
                    .font(.sprenParagraph)
                Spacer()
            }
        }
        .padding()
        .background(colorScheme == .light ? Color.white : Color.black)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 8)
    }
}

struct ResultCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack {
                ResultCard(title: "HRV Score", value: 58, label: "")
                ResultCard(title: "Heart Rate", value: 66, label: "bpm")
                Spacer()
            }
            VStack {
                ResultCard(title: "Respiration", value: 17, label: "rpm")
                Spacer()
            }
        }
        .padding()
    }
}
