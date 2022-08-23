//
//  HomeAnimation.swift
//  SprenInternal
//
//  Created by Keith Carolus on 1/31/22.
//

import SwiftUI

struct HomeAnimation: View {
    
    @State var viewModel = ViewModel()

    struct ViewModel {
        var home3Y: CGFloat = -120
        var home1Opacity: CGFloat = 1
        var home3Opacity: CGFloat = 1
        var home4Opacity: CGFloat = 1
    }
    
    var body: some View {
        ZStack(alignment: .top) {
            Image("animation-home-1", bundle: .module)
                .resizable()
                .frame(width: 254, height: 182)
                .opacity(viewModel.home1Opacity)
            Image("animation-home-2", bundle: .module)
                .resizable()
                .frame(width: 254, height: 143)
            Image("animation-home-4", bundle: .module)
                .resizable()
                .frame(width: 115, height: 210)
                .opacity(viewModel.home4Opacity)
                .offset(x: 0, y: -110)
            Image("animation-home-3", bundle: .module)
                .resizable()
                .frame(width: 195, height: 164)
                .opacity(viewModel.home3Opacity)
                .offset(x: 0, y: viewModel.home3Y)
            Image("animation-home-7", bundle: .module)
                .resizable()
                .frame(width: 58, height: 40)
                .offset(x: 0, y: -130)
            Image("animation-home-5", bundle: .module)
                .resizable()
                .frame(width: 63, height: 61)
                .offset(x: 0, y: -110)
            Image("animation-home-6", bundle: .module)
                .resizable()
                .frame(width: 65, height: 69)
                .offset(x: 0, y: -18)
        }
        .frame(width: 254, height: 312)
        .offset(x: 0, y: 79)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 1.6).repeatForever()) {
                viewModel.home3Y = -90
                viewModel.home1Opacity = 0.75
                viewModel.home3Opacity = 0.65
                viewModel.home4Opacity = 0.35
            }
        }
    }
}

struct HomeAnimation_Previews: PreviewProvider {
    static var previews: some View {
        HomeAnimation()
    }
}
