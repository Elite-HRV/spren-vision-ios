// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Spren",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Spren",
            targets: ["Spren"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .binaryTarget(
            name: "Spren",
            url: "https://api.codemagic.io/artifacts/8a727f55-c36a-4b8b-aed3-92097434e9a6/5dfb3ad3-ed03-456b-a4b5-62447b212bca/Spren_iOS_6_artifacts.zip",
            checksum: "d15d226dd048e6e539d43e3c7992a4f657b315fa0a9fa799c6313f167da61736"
        ),
    ]
)
