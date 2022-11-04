//
//  SetupGuide.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//

import SwiftUI
import UIKit
import AVFoundation
import PhotosUI

typealias OnChooseHandler = ((_ selectedImage: UIImage) -> Void)

struct SetupGuide: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showingOptions = false
    @State private var permissionStatus = "notDetermined"
    @State private var isImagePickerDisplay = false
    @State private var navigateTo: String?
    @State private var selectedImage: UIImage?

    var body: some View {
        ZStack {
            
            Color(colorScheme == .light ? .white : .black).edgesIgnoringSafeArea(.all)
            
            ZStack {
                
                getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark).edgesIgnoringSafeArea(.top)
                
                
                VStack {
                    ScrollView {
                        CloseButton(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }).padding(.horizontal, Autoscale.convert(16))
                        
                        if SprenUI.config.bundle == .module {
                            Image(SprenUI.config.graphics[.setupGuide] ?? "", bundle: .module).resizable()
                                .aspectRatio(contentMode: .fit)
                                .colorMultiply(.sprenUISecondaryColor.opacity(0.75))
                        } else {
                            Image(SprenUI.config.graphics[.setupGuide] ?? "", bundle: .module).resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        title
                            .padding(.horizontal, Autoscale.convert(16))
                            .padding(.bottom, Autoscale.convert(16))
                        
                        VStack(spacing: 8) {
                            Hint(text: "Find a well-lit location")
                            Hint(text: "Avoid background objects and furniture")
                            Hint(text: "Place the camera at hip or waist height")
                            Hint(text: "Center your whole body in the photo")
                            Hint(text: "Wear athletic, tightly fitting clothes")
                            Hint(text: "Take off your shoes")
                            Hint(text: "Pull your hair back and take off your hat")
                        }.padding(.horizontal, Autoscale.convert(16))
                    }
                    
                    Spacer()
                    button

                    NavigationLink(destination: CameraAccessDenied(), tag: "CameraAccessDenied", selection: $navigateTo) { EmptyView() }
                    NavigationLink(destination: PhotoAccessDenied(), tag: "PhotoAccessDenied", selection: $navigateTo) { EmptyView() }
                    NavigationLink(destination: CameraScreen(), tag: "CameraScreen", selection: $navigateTo) { EmptyView() }
                    
                    if let selectedImage = $selectedImage.wrappedValue {
                        NavigationLink(destination: ConfirmationScreen(image: selectedImage), tag: "ConfirmationScreen", selection: $navigateTo) { EmptyView() }
                    }
                }
            }
        }.onAppear {
            checkAccess(request: false)
        }.sheet(isPresented: self.$isImagePickerDisplay) {
            ImagePickerView(onChoose: { image in
                selectedImage = image
                navigateTo = "ConfirmationScreen"
            })
        }
        .navigationBarHidden(true)
    }

    var title: some View {
        HStack {
            Text("Hints for accurate measurement results")
                .font(.sprenTitle)
                .lineLimit(2)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
            Spacer()
        }.padding(.top, Autoscale.convert(15))
    }
    
    var button: some View {
        ZStack {
            Color(colorScheme == .light ? .white : .black)

            VStack {
                Spacer()

                Button {
                    showingOptions = true
                } label: {
                    PurpleButton(text: "Start measurement")
                }
                .actionSheet(isPresented: $showingOptions) {
                    ActionSheet(
                        title: Text("Take a photo or upload one you already have").font(.sprenTitle),
                        buttons: [
                            .default(Text("Take photo")) {
                                checkAccess(request: true)
                            },

                            .default(Text("Upload from my device")) {
                                checkPhotosAccess(route: "library")
                            },

                            .cancel(Text("Cancel"))
                        ]
                    )
                }
            }.padding(.bottom, Autoscale.convert(10)).padding(.horizontal, Autoscale.convert(16))
        }.frame(maxHeight: Autoscale.convert(80))
    }

    func checkAccess(request: Bool) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // The user has previously granted access to the camera.
            permissionStatus = "authorized"

            if(request == true) {
                checkPhotosAccess(route: "camera")
            }
            return
        
        case .notDetermined: // The user has not yet been asked for camera access.
            permissionStatus = "notDetermined"
        
            if(request == true) {
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        checkPhotosAccess(route: "camera")
                    } else {
                        goDenied()
                    }
                }
            }
        
        case .denied: // The user has previously denied access.
            permissionStatus = "denied"

            if(request == true) {
                goDenied()
            }

        case .restricted: // The user can't grant access due to restrictions.
            permissionStatus = "restricted"

            if(request == true) {
                goDenied()
            }
        @unknown default:
            permissionStatus = "notDetermined"
        }
    }
    
    func checkPhotosAccess(route: String) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: {status in
            switch status {
            case .authorized:
                if(route == "camera"){
                    goNext()
                }else{
                    showPhotoLibrary()
                }
                return
            case .denied:
                goPhotoDenied()
                return
            case .limited:
                requestPhotoAccess(route: route)
                return
            case .notDetermined:
                requestPhotoAccess(route: route)
                return
            case .restricted:
                goPhotoDenied()
                return

            @unknown default:
                goPhotoDenied()
                return
            }
        })
    }
    
    func requestPhotoAccess(route: String) {
        PHPhotoLibrary.requestAuthorization(for: .readWrite) { granted in
            if granted == .authorized || granted == .limited {
                if(route == "camera"){
                    goNext()
                }else{
                    showPhotoLibrary()
                }
            } else {
                print("show photo denied")
                goPhotoDenied()
            }
        }
    }

    func showPhotoLibrary() {
        self.isImagePickerDisplay.toggle()
    }

    func goNext() {
        navigateTo = "CameraScreen"
    }

    func goDenied() {
        navigateTo = "CameraAccessDenied"
    }
    
    func goPhotoDenied() {
        navigateTo = "PhotoAccessDenied"
    }
}

struct SetupGuide_Previews: PreviewProvider {
    static var previews: some View {
        SetupGuide()
    }
}
