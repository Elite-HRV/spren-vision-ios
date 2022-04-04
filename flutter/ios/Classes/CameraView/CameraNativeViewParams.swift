//
//  CameraNativeViewParams.swift
//  spren-flutter
//
//  Created by nick on 22.03.2022.
//

import Foundation

struct CameraNativeViewParams {
    var width: CGFloat = UIScreen.main.bounds.width
    var height: CGFloat = UIScreen.main.bounds.height

    init(dict: Dictionary<String, Any>) {
        self.width = dict["width"] == nil ? self.width : dict["width"] as! CGFloat
        self.height = dict["height"] == nil ? self.height : dict["height"] as! CGFloat
    }
}
