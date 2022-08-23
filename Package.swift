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
            name: "SprenUI",
            targets: ["SprenUI"]),
        .library(
            name: "SprenCapture",
            targets: ["SprenCapture"]),
        .library(
            name: "SprenCore",
            targets: ["SprenCore"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-log.git", from: "1.0.0"),
        .package(url: "https://github.com/devicekit/DeviceKit.git", from: "4.0.0"),
    ],
    targets: [
        .target(
            name: "SprenUI",
            dependencies: [
                .product(name: "Logging", package: "swift-log"),
                "DeviceKit",
                "SprenCapture",
                "SprenCore"
            ],
            path: "Sources/SprenUI"
        ),
        .target(
            name: "SprenCapture",
            dependencies: ["DeviceKit", "SprenCore"],
            path: "Sources/SprenCapture"
        ),
        .binaryTarget(
            name: "SprenCore",
            path: "Framework/SprenCore.xcframework"
        )
    ]
)
