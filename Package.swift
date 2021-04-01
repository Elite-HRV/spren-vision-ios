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
            url: "https://api.codemagic.io/artifacts/505effaa-9241-4ab4-bb27-9a84dde70c58/a9e5b67f-4a3a-4dc6-a4a2-9b30c8b9ac4b/Spren_iOS_18_artifacts.zip",
            checksum: "4aa90eab9cf4e247ab1a28ccd5f895004777f99b5918a39e70d11a77fe1ad6f1"
        ),
    ]
)
