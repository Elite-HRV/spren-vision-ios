//
//  NavigationWrapper.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

public struct SprenUI: View {
        
    static var config = Config(baseURL: "", apiKey: "", userID: "", project: SprenUI.Config.SprenProject.fingerCamera, onCancel: {}, onFinish: { _ in })
    
    @StateObject var viewModel = ViewModel()
    @State private var isActive : Bool = false
        
    public init(config: Config) {
        Self.config = config
    }
        
    public var body: some View {
        if(Self.config.project == SprenUI.Config.SprenProject.fingerCamera){
            switch viewModel.navTag {
            case .greetingScreen1:      greetingScreen1
            case .greetingScreen2:      greetingScreen2
            case .noCameraScreen:       noCameraScreen
            case .fingerOnCameraScreen: fingerOnCameraScreen
            case .readingScreen:        readingScreen
            case .uploadScreen:         uploadScreen
            case .errorScreen:          errorScreen
            case .resultsScreen:        resultsScreen
            }
        }
        
        if(Self.config.project == SprenUI.Config.SprenProject.bodyComp){
            NavigationView {
                GreetingScreen()
            }
            .accentColor(Color("AppBlack", bundle: .module))
                .navigationViewStyle(StackNavigationViewStyle())
                .environment(\.rootPresentationMode, self.$isActive)
        }
    }
}

extension SprenUI {
        
    var greetingScreen1: MessageScreen {
        MessageScreen(illustration: "GreetingScreen1",
                         title: "Measure your HRV with your phone camera",
                         paragraph: "Simply do a quick resting scan when you wake up to receive personalized stress and recovery insights.",
                         buttonText: "Next",
                      onBackButtonTap: SprenUI.config.onCancel,
                      onBottomButtonTap: { viewModel.transition(to: .greetingScreen2) })
    }
    
    var greetingScreen2: MessageScreen {
        MessageScreen(illustration: "GreetingScreen2",
                         title: "Place your fingertip on the rear-facing camera",
                         paragraph: "For the most accurate reading, leave the flash on or make sure you're in a well lit area and can hold your hand steady.",
                         buttonText: "Next",
                      onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) },
                         onBottomButtonTap: viewModel.handleVideoAuthorization)
    }
    
    var noCameraScreen: MessageScreen {
        MessageScreen(illustration: "NoCamera",
                         title: "Camera access is needed to start an HRV measurement",
                         paragraph: "Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.",
                         buttonText: "Enable camera",
                         onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) },
                         onBottomButtonTap: viewModel.handleOpenSettings)
    }
    
    var fingerOnCameraScreen: MessageScreen {
        MessageScreen(illustration: "FingerOnCamera",
                         title: "Place your fingertip fully over the camera lens",
                         paragraph: "Hold your hand steady and apply light pressure with your finger.",
                         buttonText: "Start measurement",
                      onBackButtonTap: viewModel.handleFingerOnCameraScreenBackButtonTap,
                         onBottomButtonTap: { viewModel.transition(to: .readingScreen) })
    }
    
    var readingScreen: ReadingScreen {
        ReadingScreen(viewModel: .init(onBackButtonTap: SprenUI.config.onCancel, onFinish: {
            viewModel.transition(to: .uploadScreen)
        }))
    }
    
    var uploadScreen: UploadScreen {
        UploadScreen(viewModel: .init(onCancel: {
            viewModel.transition(to: viewModel.firstScreen)
        }, onError: {
            viewModel.transition(to: .errorScreen)
        }, onFinish: { results in
            viewModel.results = results
            viewModel.transition(to: .resultsScreen)
        }))
    }
    
    var errorScreen: MessageScreen {
        MessageScreen(illustration: "Server",
                         title: "Sorry! There was an error calculating your results",
                         paragraph: "Please take another measurement to view your HRV results.",
                         buttonText: "Try again",
                         onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) },
                         onBottomButtonTap: { viewModel.transition(to: viewModel.firstScreen) })
    }
    
    var resultsScreen: ResultsScreen {
        ResultsScreen(onDoneButtonTap: Self.config.onFinish, results: viewModel.results)
    }
    
}

struct SprenUI_Previews: PreviewProvider {
    static var previews: some View {
        SprenUI(config: .init(baseURL: "", apiKey: "", userID: "", project: SprenUI.Config.SprenProject.bodyComp, onCancel: {}, onFinish: { _ in }))
//            .preferredColorScheme(.light)
//            .environment(\.colorScheme, .dark)
    }
}
