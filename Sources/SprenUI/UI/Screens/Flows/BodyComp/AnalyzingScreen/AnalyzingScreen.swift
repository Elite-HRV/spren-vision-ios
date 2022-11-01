//
//  AnalyzingScreen.swift
//  SprenInternal
//
//  Created by nick on 03.08.2022.
//

import SwiftUI

struct AnalyzingScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    static let imageHeightPercent = 0.8
    @State private var bodyCompResponse: GetBodyCompResponse?
    @State private var navigateTo: String?
    @State private var tooltip = ToolTip.inProgress
    @State var animationModel = AnimationModel()

    @State var inputImage = UIImage()
    @State var finalOutputImage = UIImage()

    let asyncAPIService = AsyncAPIService<PostBodyCompBody, GetBodyCompResponse>(
        postEndpoint: "/submit/bodyComp",
        getEndpoint: "/results/bodyComp",
        decodable: GetBodyCompResponse.self
    )
    let image: UIImage?

    var body: some View {
        if let bodyCompResponse = $bodyCompResponse.wrappedValue {
            NavigationLink(destination: BodyCompResults(bodyCompResponse: bodyCompResponse), tag: "ResultsScreen", selection: $navigateTo) { EmptyView() }
        }
        
        NavigationLink(destination: ServerError(), tag: "ServerError", selection: $navigateTo) { EmptyView() }
        NavigationLink(destination: IncorrectBodyPosition(), tag: "IncorrectBodyPosition", selection: $navigateTo) { EmptyView() }

        ZStack(alignment: .top) {
            pathTopLeft()
            pathBottomLeft()
            pathTopRight()
            pathBottomRight()
            gradient()
            line()
            VStack {
                Spacer()
                tooltip(type: tooltip)
            }
        }

        .background(UserImageMasked.default.getMesh(), alignment: .top)
        .background(
            UserImageMasked.default.getFinalImage(
                inputImage: inputImage,
                finalOutputImage: finalOutputImage,
                size: CGSize.init(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8),
                shouldApplyShadow: true
            ).padding([.top], Autoscale.convert(50)), alignment: .top
        )
        .background(Color("AppLightGray", bundle: .module))
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onAppear(perform: {
            inputImage = image!
            if #available(iOS 15.0, *) {
                finalOutputImage = UserImageMasked.default.runVisionRequest(inputImage)
            }
            DispatchQueue.main.async {
                handleAnimation()
            }
            self.asyncAPIService.onNetworkConnectivityAlert = {
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(
                        title: "Network Connection Error",
                        message: "Please check your internet connection and try again.",
                        preferredStyle: .alert
                    )
                    let closeAction = UIAlertAction(title: "Close", style: .cancel) { (action: UIAlertAction) in
                        rootPresentationMode.wrappedValue.dismiss()
                    }
                    let retryAction = UIAlertAction(title: "Try again", style: .default) { (action: UIAlertAction) in
                        upload(image: image!)
                    }
                    alertVC.addAction(retryAction)
                    alertVC.addAction(closeAction)

                    let viewController = UIApplication.shared.windows.first!.rootViewController!
                    viewController.present(alertVC, animated: true, completion: nil)
                }
            }
            self.asyncAPIService.onError = {errorDescription, isHumanNotDetectedError in
                print("AnalyzingScreen, onError", errorDescription)
                self.tooltip = ToolTip.isError
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if (isHumanNotDetectedError) {
                        navigateTo = "IncorrectBodyPosition"
                    } else {
                        navigateTo = "ServerError"
                    }
                }
            }
            self.asyncAPIService.onFinish = {bodyCompResponse in
                print("AnalyzingScreen, onFinish", bodyCompResponse)
                self.bodyCompResponse = bodyCompResponse
                self.tooltip = ToolTip.isCompleted
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    navigateTo = "ResultsScreen"
                }
            }
            upload(image: image!)
        })
    }

    struct AnimationModel {
        var lineOffset: CGFloat = 0
        var gradientY: CGFloat = 0
    }
}

struct AnalyzingScreen_Previews: PreviewProvider {
    static var previews: some View {
        AnalyzingScreen(image: UIImage())
    }
}
