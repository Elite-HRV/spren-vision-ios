//
//  CameraScreen.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 02/08/22.
//

import SwiftUI
import AVFoundation

struct CameraScreen: View {
    @Environment(\.colorScheme) var colorScheme
    
    @StateObject var model = CameraViewModel()
    
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    @State private var isTimerOpen = false
    @State private var infoTimer = 10
    @State private var navigateTo: String?
    @State private var selectedImage: UIImage?
    @State private var currentFrame: UIImage?
    @State private var points: [CGPoint]?
    @State private var leftWrist: CGPoint?
    @State private var rightWrist: CGPoint?
    @State private var leftAnkle: CGPoint?
    @State private var rightAnkle: CGPoint?
    @State private var testsEnabled = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                CameraPreview(session: model.session)
                    .edgesIgnoringSafeArea(.all)
                    .onAppear {
                        if(model.imageReady == nil){
                            model.configure()
                        }
                    }
                    .animation(.easeInOut)

                //display frame
                if(testsEnabled == true) {
                    ScreenCameraTests(currentFrame: currentFrame, leftWrist: leftWrist, rightWrist: rightWrist, leftAnkle: leftAnkle, rightAnkle: rightAnkle)
                }
                
                ZStack {
                    if(model.isTimerOn != nil && model.time != nil && model.time ?? 0 > 0) {
                        getColor(colorScheme: colorScheme, light: .sprenBodyCompBlack20Light, dark: .sprenBodyCompBlack20Dark)
                    }
                    
                    ZStack {
                        CanvasBoxes(leftWrist: leftWrist, rightWrist: rightWrist, leftAnkle: leftAnkle, rightAnkle: rightAnkle)
                        
                        VStack {
                            HStack {
                                CameraScreenFlashButton(model: model)

                                CloseButton(action: {self.rootPresentationMode.wrappedValue.dismiss()}, image: "СloseWhite")

                            }.padding(.horizontal, Autoscale.convert(16))
                            
                            Spacer()
                            
                            if(model.isTimerOn != nil && model.time != nil && model.time ?? 0 > 0) {
                                timer
                            }
                            
                            if(model.time == nil && infoTimer > 0) {
                                CameraScreenInfoCard()
                            }
                            
                            Spacer()
                            
                            if(isTimerOpen) {
                                CameraScreenTimerSelectionContainer(model: model, buttonCallBack: {
                                    isTimerOpen = !isTimerOpen
                                })
                            }
                            
                            ZStack {
                                VisualEffectView(effect: UIBlurEffect(style: .dark)).edgesIgnoringSafeArea(.bottom)

                                HStack {
                                    Spacer().frame(width: Autoscale.convert(35))

                                    timerButton

                                    Spacer()

                                    cameraButton

                                    Spacer()

                                    switchButton

                                    Spacer().frame(width: Autoscale.convert(35))
                                }
                            }.frame(height: Autoscale.convert(158))
                        }.onReceive(model.imageUpdated) {
                            goAnalyzingScreen()
                        }.onReceive(model.pointsUpdated) {
                            currentFrame = model.updatedImage
                            points = model.points
                            
                            if let currentFrame = currentFrame {
                                let proportion = UIScreen.main.bounds.height / currentFrame.size.height
                                let offset = (currentFrame.size.width * proportion - UIScreen.main.bounds.width) / 2
                                
                                if let points = points {
                                    if(points.count > 7){
                                        let leftWristHeight = points[7].x * proportion
                                        let leftWristWidth = points[7].y * proportion - offset
                                        leftWrist = CGPoint(x: leftWristWidth, y: leftWristHeight)
                                    } else {
                                        leftWrist = nil
                                    }
                                    
                                    if(points.count > 6){
                                        let rightWristHeight = points[6].x * proportion
                                        let rightWristWidth = points[6].y * proportion - offset
                                        rightWrist = CGPoint(x: rightWristWidth, y: rightWristHeight)
                                    } else {
                                        rightWrist = nil
                                    }
                                    
                                    if(points.count > 14){
                                        let leftAnkleHeight = points[14].x * proportion
                                        let leftAnkleWidth = points[14].y * proportion - offset
                                        leftAnkle = CGPoint(x: leftAnkleWidth, y: leftAnkleHeight)
                                    } else {
                                        leftAnkle = nil
                                    }
                                    
                                    if(points.count > 13){
                                        let rightAnkleHeight = points[13].x * proportion
                                        let rightAnkleWidth = points[13].y * proportion - offset
                                        rightAnkle = CGPoint(x: rightAnkleWidth, y: rightAnkleHeight)
                                    } else {
                                        rightAnkle = nil
                                    }
                                }
                            }
                        }
                    }.padding(.top, geometry.safeAreaInsets.top).padding(.bottom, geometry.safeAreaInsets.bottom)
                        
                }.edgesIgnoringSafeArea(.all)
                    
                if let selectedImage = $selectedImage.wrappedValue {
                    NavigationLink(destination: ConfirmationScreen(image: selectedImage), tag: "ConfirmationScreen", selection: $navigateTo) { EmptyView() }
                }
            }.onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    self.infoTimer -= 1

                    if self.infoTimer == 0 {
                        timer.invalidate()
                    }
                }
            }.gesture(MagnificationGesture()
                .onChanged { value in
                    model.setZoom(scale: value.magnitude)
                }.onEnded {
                    value in model.setFinalZoom(scale: value.magnitude)
                }
            )
        }.navigationBarHidden(true)
    }
    
    var timer: some View {
        if let time = model.time {
            return Text(String(time))
                .font(.sprenBigNumber)
                .foregroundColor(colorScheme == .light ? .white : .black)
        } else {
            return Text("")
        }
    }
    
    var timerButton: some View {
        Button {
            isTimerOpen = !isTimerOpen
        } label: {
            VStack {
                Spacer().frame(height: Autoscale.convert(25))
                Image("Timer", bundle: .module).colorMultiply(isTimerOpen ? .sprenUIColor1 : .white)
                
                if let isTimerOn = model.isTimerOn {
                    Text(String(isTimerOn) + "s")
                        .font(.sprenParagraph)
                        .foregroundColor(.white)
                }else{
                    Text(" ")
                }
            }
        }
    }
    
    var cameraButton: some View {
        Button {
            if(model.time ?? 0 > 0) {
                model.stopTimer()
            } else {
                model.capturePhoto()
            }
        } label: {
            if(model.time ?? 0 > 0) {
                Image("Stop", bundle: .module)
            } else {
                Image("Camera", bundle: .module)
            }
        }
    }
    
    var switchButton: some View {
        Button {
            model.flipCamera()
        } label: {
            VStack {
                Spacer().frame(height: Autoscale.convert(25))
                Image("Switch", bundle: .module).colorMultiply(model.isCameraFlipped ? .sprenUIColor1 : .white)
                Text(" ")
            }
        }
    }
    
    func goAnalyzingScreen() {
        print("goAnalyzingScreen!")
        selectedImage = model.imageReady
        navigateTo = "ConfirmationScreen"
    }
}

struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}

struct CameraScreen_Previews: PreviewProvider {
    static var previews: some View {
        CameraScreen()
    }
}
