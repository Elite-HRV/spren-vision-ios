//
//  SprenUIViewModel.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/27/22.
//

import SwiftUI
import AVKit

extension SprenUI {
    
    class ViewModel: ObservableObject {
        
        @Published var navTag: NavTag = .homeScreen
        var transition: AnyTransition = .forwardSlide
        
        @Published var hr: Double = 0
        @Published var hrvScore: Double = 0
        
        func transition(to navTag: NavTag, transition: AnyTransition) {
            self.transition = transition
            DispatchQueue.main.async {
                withAnimation {
                    self.navTag = navTag
                }
            }
        }
        
        func handleVideoAuthorization() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                self.transition(to: .readingScreen, transition: .forwardSlide)
            case .notDetermined:
               AVCaptureDevice.requestAccess(for: .video) { granted in
                   if granted {
                       self.transition(to: .fingerOnCameraScreen, transition: .forwardSlide)
                   } else {
                       self.transition(to: .noCameraScreen, transition: .forwardSlide)
                   }
               }
            case .denied:
                self.transition(to: .noCameraScreen, transition: .forwardSlide)
            case .restricted:
                self.transition(to: .noCameraScreen, transition: .forwardSlide)
            @unknown default:
                break
            }
        }
        
        func handleOpenSettings() {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    if success {
                        self.transition(to: .noCameraScreen, transition: .forwardSlide)
                    }
                })
            }
        }
        
    }
    
}
