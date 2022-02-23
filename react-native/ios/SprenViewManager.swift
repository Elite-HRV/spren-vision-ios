//
//  SprenView.swift
//  spren-ios-sdk
//
//  Created by nick on 22.02.2022.
//

import UIKit
import React

@objc(SprenViewManager)
class SprenViewManager: RCTViewManager {

    override func view() -> (SprenView) {
        return SprenView()
    }
    
    @objc(cancelReading:)
    func cancelReading(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.cancelReading()
        }
    }
    
    @objc(setAutoStart:autoStart:)
    func setAutoStart(_ node: NSNumber, autoStart: Bool) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.setAutoStart(autoStart);
        }
    }
    
    @objc(getReadingData:)
    func getReadingData(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.getReadingData()
        }
    }

    @objc(captureStart:)
    func captureStart(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.captureStart()
        }
    }
    
    @objc(captureStop:)
    func captureStop(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.captureStop()
        }
    }
    
    @objc(captureLock:)
    func captureLock(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.captureLock()
        }
    }
    
    @objc(captureUnlock:)
    func captureUnlock(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.captureUnlock()
        }
    }
    
    @objc(dropComplexity:)
    func dropComplexity(_ node: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.dropComplexity()
        }
    }
    
    @objc(setTorchMode:torchMode:)
    func setTorchMode(_ node: NSNumber, torchMode: NSNumber) {
        self.bridge!.uiManager.addUIBlock { (uiManager: RCTUIManager?, viewRegistry:[NSNumber : UIView]?) in
            let view = viewRegistry![node] as! SprenView
            if (type(of: view) != SprenView.self) {
                print("Cannot find SprenView with tag \(node)")
                return
            }
            view.setTorchMode(torchMode);
        }
    }
}
