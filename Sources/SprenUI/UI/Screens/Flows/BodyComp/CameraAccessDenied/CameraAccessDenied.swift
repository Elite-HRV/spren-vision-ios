//
//  CameraAccessDenied.swift
//  SprenInternal
//
//  Created by José Fernando Eckert on 27/07/22.
//
import AVFoundation
import SwiftUI

struct CameraAccessDenied: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            getColor(colorScheme: colorScheme, light: .sprenBodyCompBackgroundLight, dark: .sprenBodyCompBackgroundDark).edgesIgnoringSafeArea(.all)
            
            VStack {
                CloseButton(action: {self.rootPresentationMode.wrappedValue.dismiss()})

                if SprenUI.config.bundle == .module {
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
            Text("Camera access is needed to do a body composition measurement")
                .font(.sprenBigTitle)
                .lineLimit(4)
                .minimumScaleFactor(0.01)
                .multilineTextAlignment(.leading)
            Spacer()
        }
    }

    var text: some View {
        HStack {
            Text("Allow access to camera in your iOS Settings in order to receive personalized insights and guidance.")
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
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
        } label: {
            PurpleButton(text: "Enable camera")
                .onChange(of: scenePhase) { newPhase in
                if newPhase == .active {

                    if AVCaptureDevice.authorizationStatus(for: .video) ==  AVAuthorizationStatus.authorized {
                        self.presentationMode.wrappedValue.dismiss()
                    } else {
                        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                           if granted == true {
                               self.presentationMode.wrappedValue.dismiss()
                           }
                       })
                    }
                }
            }
        }
    }
}

struct CameraAccessDenied_Previews: PreviewProvider {
    static var previews: some View {
        CameraAccessDenied()
    }
}
