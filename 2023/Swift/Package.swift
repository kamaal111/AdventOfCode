// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC2023",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AOC2023",
            targets: ["AOC2023"]),
    ],
    targets: [
        .target(
            name: "AOC2023", resources: [.process("Inputs")]),
        .testTarget(
            name: "AOC2023Tests",
            dependencies: ["AOC2023"]),
    ]
)
