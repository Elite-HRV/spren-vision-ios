//
//  CameraUIView.swift
//  spren-flutter
//
//  Created by nick on 28.03.2022.
//

import Foundation
import SprenCore
import SprenVision

class CameraUIView : UIView {
    var sprenCapture: SprenCapture
    
    required init(sprenCapture: SprenCapture){
        self.sprenCapture = sprenCapture
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        try? self.sprenCapture.unlock()
        self.sprenCapture.stop()
        Spren.cancelReading()
    }
}
