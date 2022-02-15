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
            name: "Spren",
            targets: ["Spren"]),
    ],
    targets: [
        .target(
            name: "SprenCapture",
            dependencies: ["Spren"],
            path: "Sources"
        ),
        .binaryTarget(
            name: "Spren",
            path: "Framework/Spren.xcframework"
        )
    ]
)
