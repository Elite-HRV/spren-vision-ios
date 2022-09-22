//
//  SprenUI+ViewModel.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/27/22.
//

import SwiftUI
import AVKit

extension SprenUI {
    
    class ViewModel: ObservableObject {
        
        let firstScreen: NavTag = UserDefaults.standard.bool(forKey: SprenUI.config.secondReadingKey) ? .fingerOnCameraScreen : .greetingScreen1
        @Published var navTag: NavTag
        
        @Published var results: Results = .empty
        
        init() {
            navTag = firstScreen
        }
        
        func transition(to navTag: NavTag) {
            DispatchQueue.main.async {
                withAnimation {
                    self.navTag = navTag
                }
            }
        }
        
        func handleVideoAuthorization() {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                self.transition(to: .readingScreen)
            case .notDetermined:
               AVCaptureDevice.requestAccess(for: .video) { granted in
                   if granted {
                       self.transition(to: .fingerOnCameraScreen)
                   } else {
                       self.transition(to: .noCameraScreen)
                   }
               }
            case .denied:
                self.transition(to: .noCameraScreen)
            case .restricted:
                self.transition(to: .noCameraScreen)
            @unknown default:
                break
            }
        }
        
        func handleOpenSettings() {
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    if success {
                        self.transition(to: .noCameraScreen)
                    }
                })
            }
        }
        
        func handleFingerOnCameraScreenBackButtonTap() {
            if firstScreen == .fingerOnCameraScreen {
                SprenUI.config.onCancel()
            } else {
                self.transition(to: firstScreen)
            }
        }
        
    }
    
}