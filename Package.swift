// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SprenVision",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "SprenCapture",
            targets: ["SprenCapture"]),
        .library(
            name: "SprenCore",
            targets: ["SprenCore"]),
    ],
    targets: [
        .target(
            name: "SprenCapture",
            dependencies: ["SprenCore"],
            path: "Sources"
        ),
        .binaryTarget(
            name: "SprenCore",
            path: "Framework/SprenCore.xcframework"
        )
    ]
)
