//
//  SprenView.swift
//  spren-ios-sdk
//
//  Created by nick on 22.02.2022.
//

import UIKit

@objc(SprenViewManager)
class SprenViewManager: RCTViewManager {

  override func view() -> (SprenView) {
    return SprenView()
  }
}
