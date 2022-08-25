//
//  ReadingScreen.swift
//  SprenUI
//
//  Created by Keith Carolus on 11/11/21.
//
import SwiftUI

struct ReadingScreen: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @StateObject var viewModel: ViewModel
    
    let torchButtonSize = Autoscale.scaleFactor * 40
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            if let session = viewModel.sprenCapture?.session {
                VideoPreviewView(session: session)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear(perform: viewModel.turnOnFlash)
            }
            
            VStack {
                Header(backButtonColor: .white, onBackButtonTap: viewModel.onBackButtonTap)
                
                measurementProgress
                
                VStack {
                    Spacer()
                    ReadingAnimation(state: $viewModel.readingState)
                    Spacer()
                }
                    
                footer
            }
            
            if viewModel.showAlert {
                Color.black.opacity(0.5).ignoresSafeArea()
                
                ReadingAlert(title: viewModel.alertTitle,
                             paragraph: viewModel.alertParagraph,
                             primaryButtonText: viewModel.alertPrimaryButtonText,
                             onPrimaryButtonTap: viewModel.alertOnPrimaryButtonTap,
                             secondaryButtonText: viewModel.alertSecondaryButtonText,
                             onSecondaryButtonTap: viewModel.alertOnSecondaryButtonTap)
                    .padding(Autoscale.padding)
            }
            
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear {
            UIApplication.shared.isIdleTimerDisabled = false
        }
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                viewModel.onAppActive()
            }
        }
    }
}

extension ReadingScreen {
    
    var measurementProgress: some View {
        MeasurementProgress(progress: viewModel.progress,
                            text: viewModel.progressText)
            .padding(Autoscale.padding)
    }
    
    var torchToggleButton: some View {
        Image(systemName: viewModel.torchMode == .on ? "bolt.circle.fill" : "bolt.slash.circle.fill")
            .resizable()
            .frame(width: torchButtonSize,
                   height: torchButtonSize)
            .foregroundColor(.white)
            .onTapGesture {
                viewModel.onTapToggleTorch()
            }
            .padding(Autoscale.padding)
    }
    
    var footer: some View {
        HStack {
            Spacer()
            torchToggleButton
        }
    }
    
}

struct ReadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = ReadingScreen.ViewModel(onBackButtonTap: {},
                                                onFinish: {})
//        viewModel.showBrightnessAlert()
//        viewModel.showErrorAlert()
//        viewModel.showCancelAlert()
        
        return ReadingScreen(viewModel: viewModel)
    }
}
