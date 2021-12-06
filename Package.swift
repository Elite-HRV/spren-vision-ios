// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spren",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(
            name: "Spren",
            targets: ["Spren"]),
    ],
    dependencies: [],
    targets: [
        .binaryTarget(
            name: "Spren",
            path: "Framework/Spren.xcframework.zip"
        ),
    ]
)
