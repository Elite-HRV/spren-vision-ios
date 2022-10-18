//
//  NavigationWrapper.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/26/22.
//

import SwiftUI

public struct SprenUI: View {
    static var config = Config(baseURL: "", apiKey: "", userID: "", userGender: nil, userBirthdate: nil, onCancel: {}, onFinish: { _ in })
    
    @StateObject var viewModel = ViewModel()
        
    public init(config: Config) {
        Self.config = config
    }
        
    public var body: some View {
        switch viewModel.navTag {
        case .greetingScreen1a:      greetingScreen1a
        case .greetingScreen1b:      greetingScreen1b
        case .greetingScreen2:      greetingScreen2
        case .noCameraScreen:       noCameraScreen
        case .fingerOnCameraScreen: fingerOnCameraScreen
        case .readingScreen:        readingScreen
        case .uploadScreen:         uploadScreen
        case .errorScreen:          errorScreen
        case .resultsScreen:        resultsScreen
        }
    }
}

extension SprenUI {
    
    var greetingScreen1a: MessageScreen {
        MessageScreen(illustration: Self.config.graphics[.greeting1] ?? "",
                      title: "Measure your HRV and Recovery with your camera",
                      paragraph: "Simply do a quick resting scan to receive personalized stress and recovery insights.",
                      bulletsLabel: "For best HRV and recovery results:",
                      bullets: [
                        "Refrain from strenuous activity for at least 15 minutes prior to reading",
                        "Sit calmly for 1 minute before reading"
                      ],
                      buttonText: "Next",
                      onBackButtonTap: SprenUI.config.onCancel,
                      onBottomButtonTap: { viewModel.transition(to: .greetingScreen2) })
    }
    
    var greetingScreen1b: MessageScreen {
        MessageScreen(illustration: Self.config.graphics[.greeting1] ?? "",
                      title: "Take a moment to measure your recovery",
                      bulletsLabel: "For best HRV and recovery results:",
                      bullets: [
                        "Refrain from strenuous activity for at least 15 minutes prior to reading",
                        "Sit calmly for 1 minute before reading",
                        "If needed, take 6 deep, slow breaths before starting reading then breathe naturally during the reading"
                      ],
                      buttonText: "Next",
                      onBackButtonTap: SprenUI.config.onCancel,
                      onBottomButtonTap: { viewModel.transition(to: .fingerOnCameraScreen) })
    }
    
    var greetingScreen2: MessageScreen {
        MessageScreen(illustration: Self.config.graphics[.greeting2] ?? "",
                      title: "Place your fingertip on the rear-facing camera",
                      paragraph: "For the most accurate reading, leave the flash on or make sure you're in a well lit area and can hold your hand steady.",
                      buttonText: "Next",
                      onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) },
                      onBottomButtonTap: viewModel.handleVideoAuthorization)
    }
    
    var noCameraScreen: MessageScreen {
        MessageScreen(illustration: Self.config.graphics[.noCamera] ?? "",
                         title: "Camera access is needed to start an HRV measurement",
                         paragraph: "Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.",
                         buttonText: "Enable camera",
                         onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) },
                         onBottomButtonTap: viewModel.handleOpenSettings)
    }
    
    var fingerOnCameraScreen: MessageScreen {
        MessageScreen(illustration: Self.config.graphics[.fingerOnCamera] ?? "",
                      title: "Place your fingertip fully over the camera lens",
                      paragraph: "Hold your hand steady and apply light pressure with your finger.",
                      buttonText: "Start measurement",
                      onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) },
                      onBottomButtonTap: { viewModel.transition(to: .readingScreen) })
    }
    
    var readingScreen: ReadingScreen {
        ReadingScreen(viewModel: .init(onBackButtonTap: { viewModel.transition(to: viewModel.firstScreen) }, onFinish: {
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
        MessageScreen(illustration: Self.config.graphics[.serverError] ?? "",
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
        SprenUI(config: .init(baseURL: "", apiKey: "", userID: "", onCancel: {}, onFinish: { _ in }))
    }
}
