//
//  Box.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 28/07/22.
//

import SwiftUI

struct Box: View {
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
            if (title != nil && number != nil && self.status == StatusValue.Status.complete) {
                Color(.white)
                
                VStack(alignment: .leading, spacing: Autoscale.convert(22.5)) {
                    HStack {
                        Text(title!)
                            .foregroundColor(Color("AppBlack"))
                            .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 12))
                            .lineLimit(1)
                            .minimumScaleFactor(0.01)

                        Spacer()
                    }.padding(.horizontal, Autoscale.convert(16))
                    
                    HStack(alignment: .bottom) {
                        if (number != nil) {
                            Text(String(format: "%.2f", number!))
                                .foregroundColor(Color("AppBlack"))
                                .font(Font.custom("Sofia Pro Bold", size: Autoscale.scaleFactor * 40)).fontWeight(.bold)
                                .lineLimit(1)
                                .minimumScaleFactor(0.01)
                        }
                        Text(metric!)
                            .foregroundColor(Color("AppBlack"))
                            .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16)).padding(.bottom, Autoscale.convert(7))

                        Spacer()
                    }.padding(.horizontal, Autoscale.convert(16))
                }
            } else if (title != nil && status != StatusValue.Status.complete) {
                Color(.white)

                VStack {
                    Text(title!)
                        .foregroundColor(Color("AppBlack"))
                        .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 12))
                        .lineLimit(1)
                        .minimumScaleFactor(0.01)

                    if (status != nil) {
                        Text("Status: \(status!.rawValue)")
                            .foregroundColor(Color("AppBlack"))
                            .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16)).padding(.bottom, Autoscale.convert(7))
                    }
                    if (errorDescription != nil) {
                        Text(errorDescription!)
                            .foregroundColor(Color("AppBlack"))
                            .font(Font.custom("Sofia Pro Regular", size: Autoscale.scaleFactor * 16)).padding(.bottom, Autoscale.convert(7))
                    }
                }
            } else {
                Color("AppBackground")
            }
        }.frame(height: 140).cornerRadius(16).shadow(color: title != nil ? Color("Shaddow") : Color("AppBackground"), radius: 7, x: 0, y: 10)
    }
}

struct Box_Previews: PreviewProvider {
    static var previews: some View {
        Box(title: "Body Fat", number: 25, metric: "%")
    }
}
