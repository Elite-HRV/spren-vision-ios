//
//  Results.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI

struct BodyCompResults: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>

    let bodyCompResponse: GetBodyCompResponse

    var body: some View {
        ZStack {
            getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark).edgesIgnoringSafeArea(.all)

            ScrollView {
                VStack {
                    HStack {
                        done

                        Spacer()

                        info
                    }

                    Spacer().frame(height: Autoscale.convert(24))

                    ResultsTitle(text: "Your Body Composition Analysis", lines: 2)
                    let weightLabel = UserData.default.getWeightLabel()

                    VStack(spacing: Autoscale.convert(16)) {
                        HStack(spacing: Autoscale.convert(16)) {
                            Box(title: "Body Fat", number: bodyCompResponse.bodyFat.value, metric: "%", status: bodyCompResponse.bodyFat.status, errorDescription: bodyCompResponse.bodyFat.errorDescription)
                            
                            Box(title: "Lean Mass", number: UserData.default.convertToMetricIfNeeded(lbsOrKg:bodyCompResponse.leanMass.value), metric: weightLabel, status: bodyCompResponse.leanMass.status, errorDescription: bodyCompResponse.leanMass.errorDescription)
                        }

                        HStack(spacing: Autoscale.convert(16)) {
                            Box(title: "Fat Mass", number: UserData.default.convertToMetricIfNeeded(lbsOrKg: bodyCompResponse.fatMass.value), metric: weightLabel, status: bodyCompResponse.fatMass.status, errorDescription: bodyCompResponse.fatMass.errorDescription)
                            
                            Box(title: "Weight", number: UserData.default.weight, metric: weightLabel, status: StatusValue.Status.complete, errorDescription: nil)
                        }

                        HStack(spacing: Autoscale.convert(16)) {
                            Box(title: "Android Fat", number: UserData.default.convertToMetricIfNeeded(lbsOrKg: bodyCompResponse.androidFat.value), metric: weightLabel, status: bodyCompResponse.androidFat.status, errorDescription: bodyCompResponse.androidFat.errorDescription)
                            
                            Box(title: "Gynoid Fat", number: UserData.default.convertToMetricIfNeeded(lbsOrKg: bodyCompResponse.gynoidFat.value), metric: weightLabel, status: bodyCompResponse.gynoidFat.status, errorDescription: bodyCompResponse.gynoidFat.errorDescription)
                        }

                        HStack(spacing: Autoscale.convert(16)) {
                            Box(title: "Android:Gynoid", number: bodyCompResponse.androidByGynoid.value, metric: "", status: bodyCompResponse.androidByGynoid.status, errorDescription: bodyCompResponse.androidByGynoid.errorDescription)

                            Box(title: nil, number: nil, metric: nil)
                        }
                    }
                    
                    Spacer().frame(height: Autoscale.convert(50))

//                    ResultsTitle(text: "Additional metrics available to your users when demographic information is provided", lines: 3)
//
//                    text
//
//                    HStack(spacing: Autoscale.convert(16)) {
//                        Box(title: "Metabolic Rate", number: 1.168, metric: "kCal", status: StatusValue.Status.complete)
//
//                        Box(title: "Body Fat", number: 25, metric: "%", status: StatusValue.Status.complete)
//                    }.padding(.top, Autoscale.convert(24))
                    
                    Spacer().frame(height: Autoscale.convert(80))
                    
                    Image("PoweredBySpren", bundle: .module)
                        .padding(Autoscale.padding)
                }.padding(.horizontal, Autoscale.convert(16))
            }.padding(.top, 0.1)
        }.navigationBarHidden(true)
    }

    var done: some View {
        Button {
            self.rootPresentationMode.wrappedValue.dismiss()
        } label: {
            Text("Done")
                .font(.sprenButton)
                .foregroundColor(.sprenUISecondaryColor)
        }
    }

    var info: some View {
        NavigationLink(destination: Info()) {
            Image(systemName: "exclamationmark.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompGrayLight, dark: .sprenBodyCompGrayDark))
                .frame(width: Autoscale.convert(23), height: Autoscale.convert(23))
                .rotationEffect(.degrees(-180))
        }.isDetailLink(false)
    }

    var text: some View {
        Text("Go deeper with resting metabolic rate and normative indicators as well as showing progress over time")
            .font(.sprenLargeText)
            .foregroundColor(getColor(colorScheme: colorScheme, light: .sprenBodyCompBlackLight, dark: .sprenBodyCompBlackDark))
            .multilineTextAlignment(.center).padding(.top, Autoscale.convert(24))
    }    
}

struct BodyCompResults_Previews: PreviewProvider {
    static var previews: some View {
        let statusValue = StatusValue(status: StatusValue.Status.complete, value: 12.3, errorDescription: nil)
        BodyCompResults(bodyCompResponse: GetBodyCompResponse(bodyFat: statusValue, leanMass: statusValue, fatMass: statusValue, androidFat: statusValue, gynoidFat: statusValue, androidByGynoid: statusValue))
    }
}
