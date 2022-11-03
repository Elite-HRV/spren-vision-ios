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
    
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .font(.sprenParagraph)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .sprenUIPadding(.bottom)
            HStack {
                Text("\(String(format: "%.0f", value))")
                    .font(.sprenTitle)
                Text(label)
                    .font(.sprenParagraph)
                Spacer()
            }
        }
        .sprenUIPadding()
        .background(colorScheme == .light ? Color.white : Color.black)
        .cornerRadius(16)
        .shadow(color: .gray.opacity(0.2), radius: 8)
        .onTapGesture(perform: onTap)
    }
}

struct ResultCard_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            VStack {
                ResultCard(title: "HRV Score", value: 58, label: "", onTap: {})
                ResultCard(title: "Heart Rate", value: 66, label: "bpm", onTap: {})
                Spacer()
            }
            VStack {
                ResultCard(title: "Respiration", value: 17, label: "rpm", onTap: {})
                Spacer()
            }
        }
        .sprenUIPadding()
    }
}
