//
//  Box.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 28/07/22.
//

import SwiftUI

struct Box: View {
    @Environment(\.colorScheme) var colorScheme
    
    var title: String?
    var number: Double?
    var metric: String?
    let status: StatusValue.Status?
    let errorDescription: String?
    
    init(title: String?, number: Double?, metric: String?, status: StatusValue.Status? = nil, errorDescription: String? = nil) {
        self.title = title
        self.number = number
        self.metric = metric
        self.status = status
        self.errorDescription = errorDescription
    }

    var body: some View {
        ZStack {
            
            if let title = self.title {
                if(self.status == StatusValue.Status.complete){
                    Color(colorScheme == .light ? .white : .black)
                    
                    VStack(alignment: .leading, spacing: Autoscale.convert(22.5)) {
                        HStack {
                            Text(title)
                                .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
                                .font(.sprenSmallText)
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)

                            Spacer()
                        }.padding(.horizontal, Autoscale.convert(16))
                        
                        HStack(alignment: .bottom) {
                            if let number = self.number {
                                Text(String(format: "%.2f", number))
                                    .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
                                    .font(.sprenBoldNumber)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.01)
                            }
                            
                            if let metric = self.metric {
                                Text(metric)
                                    .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
                                    .font(.sprenParagraph).padding(.bottom, Autoscale.convert(7))
                            }
                            
                            Spacer()
                        }.padding(.horizontal, Autoscale.convert(16))
                    }
                } else {
                    Color(colorScheme == .light ? .white : .black)

                    VStack {
                        Text(title)
                            .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
                            .font(.sprenSmallText)
                            .lineLimit(1)
                            .minimumScaleFactor(0.01)

                        if let status = self.status {
                            Text("Status: \(status.rawValue)")
                                .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
                                .font(.sprenParagraph).padding(.bottom, Autoscale.convert(7))
                        }
                        
                        if let errorDescription = self.errorDescription {
                            Text(errorDescription)
                                .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
                                .font(.sprenParagraph).padding(.bottom, Autoscale.convert(7))
                        }
                    }
                }
            } else {
                getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark)
            }
                
        }.frame(height: 140).cornerRadius(16)
            .shadow(color: title != nil ? getColor(colorScheme: colorScheme, light: .sprenBodyCompShaddowLight, dark: .sprenBodyCompShaddowDark) : getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark), radius: 7, x: 0, y: 10)
    }
}

struct Box_Previews: PreviewProvider {
    static var previews: some View {
        Box(title: "Body Fat", number: 25, metric: "%", status: StatusValue.Status.pending)
    }
}
