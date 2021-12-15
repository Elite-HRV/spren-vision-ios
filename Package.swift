// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SprenPackage",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "SprenKit",
            targets: ["SprenKit"]),
        .library(
            name: "SprenVision",
            targets: ["SprenVision"]),
    ],
    targets: [
        .target(
            name: "SprenKit",
            path: "Sources"),
        .binaryTarget(
            name: "SprenVision",
            path: "Framework/SprenVision.xcframework"
        )
    ]
)
