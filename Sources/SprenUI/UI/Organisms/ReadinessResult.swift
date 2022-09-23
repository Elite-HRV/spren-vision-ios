//
//  ReadinessResult.swift
//  
//
//  Created by Keith Carolus on 9/23/22.
//

import SwiftUI

struct ReadinessResult: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let readiness: Int?
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Recovery").font(.sprenAlertTitle)
                    Spacer()
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "info.circle")
                            .foregroundColor(.sprenGray)
                    })
                }
                .padding()
                
                ZStack {
                    Circle()
                        .trim(from: 0.15, to: 0.85)
                        .rotation(.degrees(90))
                        .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(height: 120)
                    
                    if let color = getGaugeColor() {
                        Circle()
                            .trim(from: 0.15, to: 0.15+(CGFloat(readiness ?? 10)/10)*0.7)
                            .rotation(.degrees(90))
                            .stroke(color, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                            .frame(height: 120)
                    }

                    if let readiness = readiness {
                        VStack(spacing: 0) {
                            Text("\(readiness)")
                                .font(.sprenNumber)
                            Text(getGaugeCaption())
                                .font(.sprenLabelBold)
                                .padding(.vertical, -10)
                        }
                        .padding(.bottom)
                    } else {
                        Text("N/A")
                            .font(.sprenNumber)
                    }
                    
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Text("Recover")
                                .font(.sprenLabel)
                                .frame(width: 80)
                            
                            Text("Train Hard")
                                .font(.sprenLabel)
                                .frame(width: 80)
                            Spacer()
                        }
                    }
                }
                .frame(height: 130)
                
                if let (blurbHeadline, blurb) = getBlurb() {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text(blurbHeadline).font(.sprenAlertTitle)
                                .padding([.leading, .top, .trailing])
                            Spacer()
                        }
                        Text(blurb)
                            .font(.sprenParagraph)
                            .padding([.leading, .bottom, .trailing])
                    }
                }
            }
            .padding()
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(16)
            .shadow(color: .gray.opacity(0.2), radius: 8)

        }
        .padding()
    }
}

extension ReadinessResult {
    
    func getGaugeCaption() -> String {
        switch readiness {
        case 1, 2, 3: return "Poor"
        case 4, 5, 6: return "Pay Attention"
        case 7, 8:    return "Good"
        case 9, 10:   return "Optimal"
        case .none:   fallthrough
        default:      return ""
        }
    }
        
    func getGaugeColor() -> Color? {
        switch readiness {
        case 1, 2, 3:     return .readinessRed
        case 4, 5, 6:     return .readinessAmber
        case 7, 8, 9, 10: return .readinessGreen
        case .none:       fallthrough
        default:          return nil
        }
    }
        
    func getBlurb() -> (String, String)? {
        switch readiness {
        case 1, 2, 3:
            return [
                ("Prioritize Recovery","Your recovery is low today. Focus on active recovery, hydration, supportive nutrition, and a solid night's sleep."),
                ("Give yourself a break","Your nervous system activity is abnormally elevated. Overtraining, or under recovering, negatively impacts your performance. Rest to restore."),
                ("It's all about balance","Your recovery is abnormally low. Allowing yourself adequate recovery time will lead to increased performance. Prioritize rest and recovery today."),
            ].randomElement()
        case 4, 5, 6:
            return [
                ("Take it easier today","Your HRV balance indicates your body is responding to more stress today. Focus on lower intensity exercises and prioritize recovery."),
                ("Great day to check in","Your body's nervous system activity is elevated. It's critical to pay attention to both how you feel and your body's response to your workouts."),
                ("Listen to your body","You have lower recovery than normal. Focus today on active recovery which helps reduce muscle soreness, improve flexibility and other physiological factors."),
            ].randomElement()
        case 7, 8:
            return [
                ("Do what feels good","Your overall recovery is good. Keep it up! Healthy sleep, nutrition, and mental wellness are critical in preventing overtraining."),
                ("Going strong","Your recovery was good but with slightly elevated nervous system activity. Today is a good day to focus on form over intensity to not overdo it."),
                ("How are you feeling?","Your overall recovery is at a nice level. Listen to your body, and do what feels good today!"),
            ].randomElement()
        case 9, 10:
            return [
                ("Bring it on!","Your HRV balance indicates that you have recovered well and are ready for today’s training with moderate to high intensity."),
                ("Today’s your day","Compared to your recent baseline, your nervous system is well balanced. Tackle your workout based on how you feel."),
                ("Remarkable Recovery","You are well recovered! Your HRV balance indicates you can give it your all and will likely to recover quickly. Make today awesome!"),
            ].randomElement()
        case .none: fallthrough
        default:
            return ("Take another reading","You haven’t taken enough readings recently to generate your personal baseline. Take one more HRV Readiness reading tomorrow to receive a Readiness score and guidance.")
        }
    }

    
}


struct ReadinessResult_Previews: PreviewProvider {
    static var previews: some View {
        ReadinessResult(readiness: 6)
    }
}
