//
//  ReadingAlert.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/31/22.
//

import SwiftUI

struct ReadingAlert: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let paragraph: String
    
    let primaryButtonText: String
    let onPrimaryButtonTap: () -> Void
    
    var secondaryButtonText: String? = nil
    var onSecondaryButtonTap: (() -> Void)? = nil
    
    let exclamationSize = Autoscale.scaleFactor * 44
    let cornerRadius = Autoscale.scaleFactor * 16
    
    var body: some View {
        ZStack {
            VStack(alignment: .center) {
                Image(systemName: "exclamationmark.circle.fill")
                    .resizable()
                    .frame(width: exclamationSize, height: exclamationSize)
                    .foregroundColor(.sprenPink)
                
                Text(title)
                    .fixedSize(horizontal: false, vertical: true)
                    .multilineTextAlignment(.center)
                    .font(.sprenAlertTitle)
                    .padding(.bottom, Autoscale.padding)
                
                Text(paragraph)
                    .multilineTextAlignment(.center)
                    .font(.sprenParagraph)
                    .padding(.bottom, Autoscale.padding)
                
                VStack {
                    SprenButton(title: primaryButtonText,
                                action: onPrimaryButtonTap)
                    
                    if let sbt = secondaryButtonText, let osbt = onSecondaryButtonTap {
                        Text(sbt)
                            .font(.sprenButton)
                            .foregroundColor(.sprenPurple)
                            .onTapGesture(perform: osbt)
                            .padding(.top, Autoscale.padding/2)
                            .padding(.bottom, Autoscale.padding/2)
                    }
                }
                
            }
            .padding(Autoscale.padding)
            .background(colorScheme == .light ? Color.white : Color.black)
            .cornerRadius(cornerRadius)
        }
    }
}

struct ReadingAlert_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ReadingAlert(title: "There is not enough light for the measurement",
                         paragraph: "Please move to a well lit area or turn your flashlight on.",
                         primaryButtonText: "Turn on flash",
                         onPrimaryButtonTap: {},
                         secondaryButtonText: "Cancel",
                         onSecondaryButtonTap: {})
                .padding()
        }
        
        ZStack {
            Color.black.ignoresSafeArea()
            ReadingAlert(title: "Reading stopped, please try again",
                         paragraph: "Please make sure your finger fully covers the camera lens throughout the entire measurement.",
                         primaryButtonText: "Try again",
                         onPrimaryButtonTap: {})
                .padding()
        }
        
        ZStack {
            Color.black.ignoresSafeArea()
            ReadingAlert(title: "Your measurement is not complete",
                         paragraph: "Continue measurement in order to see your reading results.",
                         primaryButtonText: "Stop measurement",
                         onPrimaryButtonTap: {},
                         secondaryButtonText: "Continue Measurement",
                         onSecondaryButtonTap: {})
                .padding()
        }
    }
}
