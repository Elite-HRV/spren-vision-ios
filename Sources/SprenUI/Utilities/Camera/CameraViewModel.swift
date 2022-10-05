//
//  CameraViewModel.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 02/08/22.
//

import Combine
import AVFoundation
import SwiftUI

final class CameraViewModel: ObservableObject {
    
    private let service = CameraService()
    var session: AVCaptureSession

    @Published var isFlashOn = false
    @Published var isTimerOn:Int?
    @Published var isCameraFlipped = false
    @Published var time:Int?
    @Published var imageReady: UIImage?
    @Published var updatedImage: UIImage?
    @Published var points: [CGPoint]?
    let imageUpdated = PassthroughSubject<Void, Never>()
    let pointsUpdated = PassthroughSubject<Void, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        self.session = service.session
        
        service.$flashMode.sink { [weak self] (mode) in
            self?.isFlashOn = mode == .on
        }
        .store(in: &self.subscriptions)
        
        service.$time.sink { [weak self] (time) in
            self?.time = time
            if((self?.time) ?? 2 < 1) {
                self?.service.capturePhoto()
            }
        }
        .store(in: &self.subscriptions)
        
        service.$timerTime.sink { [weak self] (time) in
            self?.isTimerOn = time            
        }
        .store(in: &self.subscriptions)
        
        service.$photo.sink { [weak self] (image) in
            self?.imageReady = image?.image
            self?.imageUpdated.send()
        }
        .store(in: &self.subscriptions)
        
        service.$image.sink { [weak self] (image) in
            self?.updatedImage = image
        }
        .store(in: &self.subscriptions)
        
        service.$bodyPoints.sink { [weak self] (points) in
            self?.points = points
            self?.pointsUpdated.send()
        }
        .store(in: &self.subscriptions)
    }
    
    func configure() {
        service.configure()
    }
    
    func switchFlash() {
        service.flashMode = service.flashMode == .on ? .off : .on
    }
    
    func flipCamera() {
        service.changeCamera()
        isCameraFlipped = service.isCameraFlipped()
    }
    
    func setTimer(_ time: Int?) {
        service.setTimer(time)
    }
    
    func capturePhoto() {
        if(self.isTimerOn != nil) {
            service.runTimer()
        } else {
            service.capturePhoto()
        }
    }
    
    func stopTimer() {
        service.stopTimer()
    }
    
    func setZoom(scale: CGFloat) {
        service.updateZoom(scale: scale)
    }
    
    func setFinalZoom(scale: CGFloat) {
        service.setFinalZoom(scale: scale)
    }
}
