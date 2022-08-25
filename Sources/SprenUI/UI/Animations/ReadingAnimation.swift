//
//  ReadingAnimation.swift
//  SprenUI
//
//  Created by Keith Carolus on 1/31/22.
//

import SwiftUI
import Combine

struct ReadingAnimation: View {
    
    struct ViewModel {
        var lastState: ReadingState? = nil
        
        var circle1Alpha: CGFloat = 0.4
        var circle1Size: CGFloat = 136
        var circle1StrokeSize: CGFloat = 2
        var circle1ShadowOpacity: CGFloat = 1
        var circle2Size: CGFloat = 0
        var progressValue: Float = 0.0
    }
    
    @Binding var state: ReadingState
    @State var viewModel = ViewModel()
    
    let circleSize: CGFloat = 230
    
    var body: some View {
        ZStack(alignment: .center) {
            Color(
                .white
                    .withAlphaComponent(viewModel.circle1Alpha)
            )
            .clipShape(
                Circle()
                    .stroke(lineWidth: viewModel.circle1StrokeSize)
            )
            .frame(width:  viewModel.circle1Size,
                   height: viewModel.circle1Size)
                .shadow(color: .white.opacity(viewModel.circle1ShadowOpacity),
                        radius: 4, x: 0, y: 0)

            Circle()
                .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.25))
                )
                .frame(width:  viewModel.circle2Size,
                       height: viewModel.circle2Size)
                .shadow(color: Color.white, radius: 8, x: 0, y: 0)
            
        }
        .frame(width: circleSize, height: circleSize)
        .onAppear {
            handleAnimation()
        }
        .onChange(of: state) { _ in
            handleAnimation()
        }
    }
}

extension ReadingAnimation {
        
    func handleAnimation() {
        if viewModel.lastState == nil {
            preReadingAnimation()
        }
        
        else if viewModel.lastState == .preReading && state == .reading {
            stopPreReadingAnimation()
            startReadingAnimation()
        }
        
        else if viewModel.lastState == .reading && state == .preReading {
            stopReadingAnimation()
            preReadingAnimation()
        }
        
        viewModel.lastState = state
    }
    
    // - MARK: helper animation functions
    
    func preReadingAnimation() {
        withAnimation(Animation.easeInOut(duration: 0.7).repeatForever()) {
            viewModel.circle1StrokeSize = 4
            viewModel.circle1Alpha = 1
        }
    }
    
    func stopPreReadingAnimation() {
        withAnimation {
            viewModel.circle1StrokeSize = 2
            viewModel.circle1Alpha = 0.4
        }
    }
    
    func startReadingAnimation() {
        withAnimation(Animation.easeIn(duration: 0.28)) {
            viewModel.circle2Size = 100
        }
        DispatchQueue.main.asyncAfter(deadline: .now()+0.28) {
            readingAnimation()
        }
    }
    
    func readingAnimation() {
        withAnimation(Animation.easeIn(duration: 0.5)) {
            viewModel.circle2Size = 136
            viewModel.circle1Alpha = 0

            viewModel.circle1Size = 136
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            withAnimation(Animation.easeOut(duration: 0.5)) {
                viewModel.circle2Size = 100
                viewModel.circle1ShadowOpacity = 1
            }
            withAnimation(Animation.linear(duration: 1.5)) {
                viewModel.circle1Size = circleSize
                viewModel.circle1ShadowOpacity = 0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if state == .reading {
                readingAnimation()
            }
        }
    }
    
    func stopReadingAnimation() {
        withAnimation {
            viewModel.circle1Size = 136
            viewModel.circle2Size = 0
            viewModel.circle1ShadowOpacity = 1
            viewModel.progressValue = 0
        }
    }
    
}


struct TestReadingAnimation: View {
    
    @StateObject var viewModel = ViewModel()
    
    class ViewModel: ObservableObject {
        @Published var readingState: ReadingState = .preReading
    }
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            VStack {
                Spacer()
                ReadingAnimation(state: $viewModel.readingState)
                Spacer()
                Button(action: {
                    if viewModel.readingState == .preReading {
                        viewModel.readingState = .reading
                    } else if viewModel.readingState == .reading {
                        viewModel.readingState = .preReading
                    }
                }, label: {
                    Text("toggle animation")
                        .foregroundColor(Color.black)
                })
                .padding()
                .background(Color.white)
                .cornerRadius(10)
            }
        }
    }
}

struct TestReadingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        TestReadingAnimation()
    }
}
