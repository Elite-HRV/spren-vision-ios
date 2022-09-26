//
//  UploadScreen.swift
//  SprenUI
//
//  Created by Keith Carolus on 2/3/22.
//

import SwiftUI

struct UploadScreen: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var viewModel: ViewModel
    
    let circleSize = Autoscale.scaleFactor * 100
    let lineWidth  = Autoscale.scaleFactor * 6
    
    var body: some View {
        ZStack {
            VStack {
                Header(backButtonColor: colorScheme == .light ? .black : .white,
                       onBackButtonTap: viewModel.handleCancel)
                Spacer()
            }
            
            VStack {
                Text("Calculating your results")
                    .font(.sprenTitle)
                    .sprenUIPadding()
                Text(viewModel.messageText)
                    .font(.sprenParagraph)
                    .sprenUIPadding(.bottom, factor: 2)
                
                ZStack {
                    if viewModel.finished {
                        Image("Checkmark", bundle: .module)
                    }
                    
                    Circle()
                        .stroke(lineWidth: lineWidth)
                        .opacity(0.2)
                        .foregroundColor(Color.gray)
                        .frame(width: circleSize, height: circleSize)
                    Circle()
                        .trim(from: 0,
                              to:   viewModel.circleArc)
                        .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 270+viewModel.circleRotation))
                        .foregroundColor(Color.sprenPink)
                        .frame(width: circleSize, height: circleSize)
                }
                .sprenUIPadding()
                
            }
            
            VStack {
                Spacer()
                Text("For investigational use only. These numbers are estimates and not a substitute for the judgment of a health care professional. They are intended to improve awareness of general fitness and wellness.")
                    .font(.disclaimer)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.sprenGray)
                    .sprenUIPadding()
                Image("PoweredBySpren", bundle: .module)
                    .sprenUIPadding()
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Network Connection Error"),
                  message: Text("Please check your internet connection and try again."),
                  primaryButton: .default(Text("Try again"), action: viewModel.handleTapTryAgain),
                  secondaryButton: .destructive(Text("Cancel"), action: viewModel.handleCancel))
        }
    }
}

struct UploadScreen_Previews: PreviewProvider {
    static var previews: some View {
        UploadScreen(viewModel: .init(onCancel: {}, onError: {}, onFinish: { _ in }))
    }
}
