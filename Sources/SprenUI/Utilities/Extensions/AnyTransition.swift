//
//  AnyTransition.swift
//  SprenInternal
//
//  Created by Keith Carolus on 2/14/22.
//

import Foundation
import SwiftUI

extension AnyTransition {
    static var forwardSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal:   .move(edge: .leading)
        )
    }
    
    static var backwardsSlide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .leading),
            removal:   .move(edge: .trailing)
        )
    }
}
