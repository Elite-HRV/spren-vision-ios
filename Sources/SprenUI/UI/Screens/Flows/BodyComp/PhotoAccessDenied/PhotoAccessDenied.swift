//
//  PhotoAccessDenied.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 01/08/22.
//

import SwiftUI
import Photos

struct PhotoAccessDenied: View {
    
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            Color("AppBackground", bundle: .module).edgesIgnoringSafeArea(.all)
            
            VStack {
                CloseButton(action: {self.rootPresentationMode.wrappedValue.dismiss()})

                if (SprenUI.config.bundle == .module) {
                    Image(SprenUI.config.graphics[.cameraAccessDenied] ?? "", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .colorMultiply(Color.sprenUIColor1.opacity(0.75))
                        .padding(.horizontal, Autoscale.convert(30))
                }else{
                    Image(SprenUI.config.graphics[.cameraAccessDenied] ?? "", bundle: .module)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, Autoscale.convert(30))
                }

                title

                Spacer().frame(height: Autoscale.convert(13))

                text

                Spacer()

                button.padding(.bottom, 10)
            }
            .padding(.horizontal, 16)
        }.navigationBarHidden(true)
    }

    var title: some View {
        HStack {
            Text("Access to Photos is needed to upload a photo for body composition analysis")
                .font(.sprenTitle)
                .lineLimit(4)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }

    var text: some View {
        HStack {
            Text("Allow access to Photos in your iOS Settings in order to receive personalized insights and guidance.")
                .font(.sprenParagraph)
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .minimumScaleFactor(0.01)
                .lineSpacing(Autoscale.convert(3))
            Spacer()
        }
    }
    
    var button: some View {
        Button {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        } label: {
            PurpleButton(text: "Allow access")
                .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {

                    if (PHPhotoLibrary.authorizationStatus(for: .readWrite) == PHAuthorizationStatus.authorized ||
                        PHPhotoLibrary.authorizationStatus(for: .readWrite) == PHAuthorizationStatus.limited) {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        PHPhotoLibrary.requestAuthorization(for: .readWrite, handler: { (status: PHAuthorizationStatus) -> Void in
                            if status == .authorized || status == .limited {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        })
                    }
                }
            }
        }
    }
}

struct PhotoAccessDenied_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAccessDenied()
    }
}
