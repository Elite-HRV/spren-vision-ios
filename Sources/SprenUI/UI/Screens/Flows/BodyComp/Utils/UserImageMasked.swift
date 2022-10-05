//
//  UserImageMasked.swift
//  SprenInternal
//
//  Created by nick on 30.08.2022.
//

import SwiftUI
import Vision
import CoreImage.CIFilterBuiltins

struct UserImageMasked {
    static let `default`: UserImageMasked = {
        return UserImageMasked()
    }()

    @available(iOS 15.0, *)
    func runVisionRequest(_ inputImage: UIImage) -> UIImage {
        let request = VNGeneratePersonSegmentationRequest()
        request.qualityLevel = .accurate
        request.outputPixelFormat = kCVPixelFormatType_OneComponent8

        let handler = VNImageRequestHandler(cgImage: inputImage.cgImage!, options: [:])
        do {
            try handler.perform([request])

            let mask = request.results!.first!
            let maskBuffer = mask.pixelBuffer
            return maskInputImage(inputImage, maskBuffer)
        } catch {
            print(error)
            return inputImage
        }
    }
    
    func maskInputImage(_ inputImage: UIImage, _ buffer: CVPixelBuffer) -> UIImage {
//        let bgImage = UIImage(named: "background")!

        let input = CIImage(cgImage: inputImage.cgImage!)
        let mask = CIImage(cvPixelBuffer: buffer)
//        let background = CIImage(cgImage: bgImage.cgImage!)

        let maskScaleX = input.extent.width / mask.extent.width
        let maskScaleY = input.extent.height / mask.extent.height

        let maskScaled = mask.transformed(by: __CGAffineTransformMake(maskScaleX, 0, 0, maskScaleY, 0, 0))

//        let backgroundScaleX = input.extent.width / background.extent.width
//        let backgroundScaleY = input.extent.height / background.extent.height
//
//        let backgroundScaled =  background.transformed(by: __CGAffineTransformMake(backgroundScaleX, 0, 0, backgroundScaleY, 0, 0))

        let overlay = UIImage(named: "Square")!.resized(to: CGSize(width: input.extent.width, height: input.extent.height))
        let overlayCGImage = CIImage(cgImage: overlay.cgImage!)

        let blendFilter = CIFilter.blendWithMask()
        blendFilter.inputImage = overlayCGImage // input
//        blendFilter.backgroundImage = backgroundScaled
        blendFilter.maskImage = maskScaled

        if let blendedImage = blendFilter.outputImage {
            let ciContext = CIContext(options: nil)
            let filteredImageRef = ciContext.createCGImage(blendedImage, from: blendedImage.extent)
//            let maskDisplayRef = ciContext.createCGImage(maskScaled, from: maskScaled.extent)

            return UIImage(cgImage: filteredImageRef!)
        }

        return inputImage
    }

    func getFinalImage(inputImage: UIImage, finalOutputImage: UIImage, size: CGSize, shouldApplyShadow: Bool) -> some View {
        if #available(iOS 15.0, *) {
            let image = Image(uiImage: finalOutputImage)
                .resizable()
                .rotationEffect(inputImage.getRotationAngle())
                .scaledToFill()
                .frame(width: size.width, height: size.height)

            if (shouldApplyShadow) {
                return AnyView(
                    image
                        .shadow(color: Color(red: 190 / 255, green: 190 / 255, blue: 190 / 255).opacity(0.5), radius: 10, x: -40, y: 5)
                )
            }
            return AnyView(image)
        } else {
            return AnyView(Image(uiImage: inputImage)
                .resizable()
//                .rotationEffect(inputImage.getRotationAngle())
                .scaledToFill()
                .frame(width: size.width, height: size.height)
            )
        }
    }

    func getMesh() -> some View {
//        if #available(iOS 15.0, *) {
//            return AnyView(Image("BodyMesh")
//                .resizable()
//                .scaledToFill()
//                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height * 0.8)
//                .padding([.top], Autoscale.convert(50))
//                .mask {
//                getFinalImage(shouldApplyShadow: false)
//                }
//            )
//        } else {
            return AnyView(Color.red.opacity(0))
//        }
    }
}
