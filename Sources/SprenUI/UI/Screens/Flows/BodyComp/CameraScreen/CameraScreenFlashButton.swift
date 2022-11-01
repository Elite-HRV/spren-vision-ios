//
//  CameraScreenFlashButton.swift
//  SprenInternal
//
//  Created by Fernando on 8/18/22.
//

import SwiftUI

struct CameraScreenFlashButton: View {
    @StateObject var model: CameraViewModel
    
    var body: some View {
        Button {
            model.switchFlash()
        } label: {
            ZStack {
                Circle().fill(.white).frame(width: Autoscale.convert(44), height: Autoscale.convert(44))
                if(model.isFlashOn) {
                    Image(systemName: "bolt.fill").colorMultiply(.black)
                } else {
                    ZStack {
                        Circle().fill(.white).frame(width: Autoscale.convert(44), height: Autoscale.convert(44))
                        Image(systemName: "bolt.slash.fill").colorMultiply(.black)
                    }
                }
            }
        }
    }
}

struct CameraScreenFlashButton_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreenFlashButton(model: CameraViewModel())
    }
}
