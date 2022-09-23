//
//  ANSBalanceResult.swift
//  
//
//  Created by Keith Carolus on 9/23/22.
//

import SwiftUI

struct ANSBalanceResult: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let ansBalance: Int
    let onInfoButtonTap: () -> Void
    
    let lineHeight = Autoscale.scaleFactor * 12
    let triangleSize = Autoscale.scaleFactor * 15
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("ANS Balance").font(.sprenAlertTitle)
                    Spacer()
                    Button(action: onInfoButtonTap, label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.sprenGray)
                    })
                }
                .padding()
                
                if let blurb = getBlurb() {
                    Text(blurb)
                        .font(.sprenParagraph)
                        .padding([.leading, .trailing])
                }
                
                ANSBalanceBar(ansBalance: ansBalance)
                    .padding([.leading, .trailing])

            }
            .padding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)

        }
        .padding()
    }
}

extension ANSBalanceResult {
    
    func getBlurb() -> String? {
        switch ansBalance {
        case 1:  return "Your Sympathetic Nervous System is more strongly engaged, meaning your body is experiencing deeper levels of stress or fatigue."
        case 2:  return "Your Sympathetic Nervous System is more engaged, indicating greater than usual stress (from all sources)."
        case 3:  return "Your autonomic nervous system is relatively balanced today, meaning you are more rested and recovered."
        case 4:  return "Your Parasympathetic Nervous System is more engaged indicating your recovery activity is slightly elevated in response to recent stressors."
        case 5:  return "Your Parasympathetic Nervous System is strongly engaged indicating excessive recovery activity, often in response to cumulative stress or elevated immune system activity."
        default: return nil
        }
    }
    
}

struct ANSBalanceResult_Previews: PreviewProvider {
    static var previews: some View {
        ANSBalanceResult(ansBalance: 5, onInfoButtonTap: {})
    }
}
