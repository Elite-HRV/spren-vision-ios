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
            url: "https://api.codemagic.io/artifacts/2c5fa87c-f435-422d-ab1f-63c2b5c445a4/bb932ae7-9f3c-41c1-b2fe-7d66fb3a6ce9/Spren_iOS_19_artifacts.zip",
            checksum: "7b3c7d1e9de0324ec7d077b310f40a8257fa0f131706099aed8d588f99d821e2"
        ),
    ]
)
