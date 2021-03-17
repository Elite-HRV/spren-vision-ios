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
            url: "https://api.codemagic.io/artifacts/e9af9a91-fcd6-4d8d-bf10-fb035e213bb1/c7baf7d1-ab90-49e7-a5ae-16a596f2a396/Spren_iOS_8_artifacts.zip",
            checksum: "030b5c323b15a30625405d7b307ad2b09879e555742cee00baa90a32da418b23"
        ),
    ]
)
