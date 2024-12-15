// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC",
    products: [
        .library(
            name: "AOC",
            targets: ["AOC"]),
    ],
    targets: [
        .target(
            name: "AOC"),
        .testTarget(
            name: "AOCTests",
            dependencies: ["AOC"],
            resources: [.process("Inputs")]
        ),
    ]
)
