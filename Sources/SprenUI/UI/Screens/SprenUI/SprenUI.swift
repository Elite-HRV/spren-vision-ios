//
//  NavigationWrapper.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

public struct SprenUI: View {
        
    static var config = Config(baseURL: "", apiKey: "", userID: "")
    
    @StateObject var viewModel = ViewModel()
    
    public init(config: Config) {
        Self.config = config
    }
        
    public var body: some View {
        switch viewModel.navTag {
        case .homeScreen:
            home
                .transition(viewModel.transition)
        case .greetingScreen1:
            greetingScreen1
                .transition(viewModel.transition)
        case .greetingScreen2:
            greetingScreen2
                .transition(viewModel.transition)
        case .noCameraScreen:
            noCameraScreen
                .transition(viewModel.transition)
        case .fingerOnCameraScreen:
            fingerOnCameraScreen
                .transition(viewModel.transition)
        case .readingScreen:
            readingScreen
                .transition(viewModel.transition)
        case .uploadScreen:
            uploadScreen
                .transition(viewModel.transition)
        case .errorScreen:
            errorScreen
                .transition(viewModel.transition)
        case .resultsScreen:
            resultsScreen
                .transition(viewModel.transition)
        }
    }
}

extension SprenUI {
    
    var home: MessageScreen {
        MessageScreen(illustration: "Home",
                         title: "Unlock advanced HRV insights with your smartphone camera",
                         paragraph: "•  Integrate via SDK and API\n•  Customizable look and feel\n•  Validated algorithms",
                         buttonText: "Try it now",
                         textVStackAlignment: .center,
                         titleTextAlignment: .center,
                      onBottomButtonTap: { viewModel.transition(to: .greetingScreen1, transition: .forwardSlide) })
    }
    
    var greetingScreen1: MessageScreen {
        MessageScreen(illustration: "GreetingScreen1",
                         title: "Measure your HRV with your phone camera",
                         paragraph: "Simply do a quick resting scan when you wake up to receive personalized stress and recovery insights.",
                         buttonText: "Next",
                      onBackButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) },
                      onBottomButtonTap: { viewModel.transition(to: .greetingScreen2, transition: .forwardSlide) })
    }
    
    var greetingScreen2: MessageScreen {
        MessageScreen(illustration: "GreetingScreen2",
                         title: "Place your fingertip on the rear-facing camera",
                         paragraph: "For the most accurate reading, leave the flash on or make sure you're in a well lit area and can hold your hand steady.",
                         buttonText: "Next",
                         onBackButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) },
                         onBottomButtonTap: viewModel.handleVideoAuthorization)
    }
    
    var noCameraScreen: MessageScreen {
        MessageScreen(illustration: "NoCamera",
                         title: "Camera access is needed to start an HRV measurement",
                         paragraph: "Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.",
                         buttonText: "Enable camera",
                         onBackButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) },
                         onBottomButtonTap: viewModel.handleOpenSettings)
    }
    
    var fingerOnCameraScreen: MessageScreen {
        MessageScreen(illustration: "FingerOnCamera",
                         title: "Place your fingertip fully over the camera lens",
                         paragraph: "Hold your hand steady and apply light pressure with your finger.",
                         buttonText: "Start measurement",
                         onBackButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) },
                         onBottomButtonTap: { viewModel.transition(to: .readingScreen, transition: .forwardSlide) })
    }
    
    var readingScreen: ReadingScreen {
        ReadingScreen(viewModel: .init(onBackButtonTap: {
            viewModel.transition(to: .homeScreen, transition: .backwardsSlide)
        }, onFinish: {
            viewModel.transition(to: .uploadScreen, transition: .forwardSlide)
        }))
    }
    
    var uploadScreen: UploadScreen {
        UploadScreen(viewModel: .init(onCancel: {
            viewModel.transition(to: .homeScreen, transition: .backwardsSlide)
        }, onError: {
            viewModel.transition(to: .errorScreen, transition: .forwardSlide)
        }, onFinish: { hr, hrvScore in
            
            viewModel.hr = hr
            viewModel.hrvScore = hrvScore
            
            viewModel.transition(to: .resultsScreen, transition: .forwardSlide)
        }))
    }
    
    var errorScreen: MessageScreen {
        MessageScreen(illustration: "Server",
                         title: "Sorry! There was an error calculating your results",
                         paragraph: "Please take another measurement to view your HRV results.",
                         buttonText: "Try again",
                         onBackButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) },
                         onBottomButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) })
    }
    
    var resultsScreen: ResultsScreen {
        ResultsScreen(onDoneButtonTap: { viewModel.transition(to: .homeScreen, transition: .backwardsSlide) },
                      hrvScore: viewModel.hrvScore,
                      hr: viewModel.hr)
    }
    
}

struct NavigationWrapper_Previews: PreviewProvider {
    static var previews: some View {
        SprenUI(config: .init(baseURL: "", apiKey: "", userID: ""))
//            .preferredColorScheme(.light)
//            .environment(\.colorScheme, .dark)
    }
}
