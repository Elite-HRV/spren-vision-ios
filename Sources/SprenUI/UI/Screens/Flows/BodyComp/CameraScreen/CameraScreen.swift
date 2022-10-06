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
                        model.configure()
                    }
                    .animation(.easeInOut)

                //display frame
                if(testsEnabled == true) {
                    ScreenCameraTests(currentFrame: currentFrame, leftWrist: leftWrist, rightWrist: rightWrist, leftAnkle: leftAnkle, rightAnkle: rightAnkle)
                }
                
                ZStack {
                    if(model.isTimerOn != nil && model.time != nil && model.time ?? 0 > 0) {
                        Color("Black20", bundle: .module)
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
                            
                            if(currentFrame != nil){
                                let proportion = UIScreen.main.bounds.height / currentFrame!.size.height
                                let offset = (currentFrame!.size.width * proportion - UIScreen.main.bounds.width) / 2
                                
                                if(points!.count > 7){
                                    let leftWristHeight = (points?[7].x ?? 0) * proportion
                                    let leftWristWidth = (points?[7].y ?? 0) * proportion - offset
                                    leftWrist = CGPoint(x: leftWristWidth, y: leftWristHeight)
                                } else {
                                    leftWrist = nil
                                }
                                
                                if(points!.count > 6){
                                    let rightWristHeight = (points?[6].x ?? 0) * proportion
                                    let rightWristWidth = (points?[6].y ?? 0) * proportion - offset
                                    rightWrist = CGPoint(x: rightWristWidth, y: rightWristHeight)
                                } else {
                                    rightWrist = nil
                                }
                                
                                if(points!.count > 14){
                                    let leftAnkleHeight = (points?[14].x ?? 0) * proportion
                                    let leftAnkleWidth = (points?[14].y ?? 0) * proportion - offset
                                    leftAnkle = CGPoint(x: leftAnkleWidth, y: leftAnkleHeight)
                                } else {
                                    leftAnkle = nil
                                }
                                
                                if(points!.count > 13){
                                    let rightAnkleHeight = (points?[13].x ?? 0) * proportion
                                    let rightAnkleWidth = (points?[13].y ?? 0) * proportion - offset
                                    rightAnkle = CGPoint(x: rightAnkleWidth, y: rightAnkleHeight)
                                } else {
                                    rightAnkle = nil
                                }
                            }
                        }
                    }.padding(.top, geometry.safeAreaInsets.top).padding(.bottom, geometry.safeAreaInsets.bottom)
                        
                }.edgesIgnoringSafeArea(.all)
                    
                
                NavigationLink(destination: ConfirmationScreen(image: $selectedImage.wrappedValue), tag: "ConfirmationScreen", selection: $navigateTo) { EmptyView() }
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
        Text(String(model.time!))
            .font(.sprenBigNumber)
            .foregroundColor(colorScheme == .light ? .white : .black)
    }
    
    var timerButton: some View {
        Button {
            isTimerOpen = !isTimerOpen
        } label: {
            VStack {
                Spacer().frame(height: Autoscale.convert(25))
                Image(isTimerOpen ? "TimerRed" : "Timer", bundle: .module)
                Text(model.isTimerOn != nil ? String(model.isTimerOn!) + "s" : " ")
                    .font(.sprenParagraph)
                    .foregroundColor(colorScheme == .light ? .white : .black)
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
                Image(model.isCameraFlipped ? "SwitchRed" : "Switch", bundle: .module)
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
