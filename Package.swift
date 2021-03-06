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
            url: "https://api.codemagic.io/artifacts/bc09fb00-1b2a-40c4-b95c-0d97759a925d/4b4da198-76ee-4a57-8980-a9c1351260ed/Spren_iOS_5_artifacts.zip",
            checksum: "565d53091ac859121158dff4e830d9db98e9a1bda6f05a71038845806b16fc97"
        ),
    ]
)
