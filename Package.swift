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
            url: "https://api.codemagic.io/artifacts/5ebaa624-6f7a-4bb1-9698-cba0df94d92f/2b55055e-3bf3-4f51-a67f-788e04284b77/Spren_iOS_13_artifacts.zip",
            checksum: "ae58db4cdbe4739178b8b2b5efdf7ed2e4c226dd4868303b901cf2cbdf802ffe"
        ),
    ]
)
