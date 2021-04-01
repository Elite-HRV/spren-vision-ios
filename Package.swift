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
            url: "https://api.codemagic.io/artifacts/b2e13a44-412d-4dfa-b77f-3c93d02b60cf/ba8ddbb3-0660-4f39-aa4c-820f67c71dca/Spren_iOS_16_artifacts.zip",
            checksum: "c32902f886c5129e51717a63afc602d6b621be641c438c62dd3c9af467fa5999"
        ),
    ]
)
