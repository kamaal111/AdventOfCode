// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC2021",
    platforms: [
        .iOS(.v9), .tvOS(.v10), .macOS(.v10_11)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "AOC2021",
            targets: ["AOC2021"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kamaal111/ShrimpExtensions.git", "2.2.0"..<"3.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "AOC2021",
            dependencies: ["ShrimpExtensions"],
            resources: [.process("Inputs")]),
        .testTarget(
            name: "AOC2021Tests",
            dependencies: ["AOC2021"]),
    ]
)
