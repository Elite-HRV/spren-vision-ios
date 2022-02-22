import UIKit

@objc(SprenViewManager)
class SprenViewManager: RCTViewManager {

  override func view() -> (SprenView) {
    return SprenView()
  }
}
