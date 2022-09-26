//
//  SprenUIPadding.swift
//  
//
//  Created by Keith Carolus on 9/26/22.
//

import SwiftUI

struct SprenUIPadding: ViewModifier {
    
    let edges: SwiftUI.Edge.Set
    let factor: CGFloat
    
    func body(content: Content) -> some View {
        content
            .padding(edges, factor*Autoscale.padding)
    }
}

extension View {
    func sprenUIPadding() -> some View {
        modifier(SprenUIPadding(edges: .all, factor: 1))
    }
    
    func sprenUIPadding(factor: CGFloat) -> some View {
        modifier(SprenUIPadding(edges: .all, factor: factor))
    }
    
    func sprenUIPadding(_ edges: SwiftUI.Edge.Set) -> some View {
        modifier(SprenUIPadding(edges: edges, factor: 1))
    }
    
    func sprenUIPadding(_ edges: SwiftUI.Edge.Set, factor: CGFloat) -> some View {
        modifier(SprenUIPadding(edges: edges, factor: factor))
    }
}
