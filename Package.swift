// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SprenKit",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SprenCapture",
            targets: ["SprenCapture"]),
        .library(
            name: "SprenVision",
            targets: ["SprenVision"]),
    ],
    targets: [
        .target(
            name: "SprenCapture",
            dependencies: ["SprenVision"],
            path: "Sources"
        ),
        .binaryTarget(
            name: "SprenVision",
            path: "Framework/SprenVision.xcframework"
        )
    ]
)
