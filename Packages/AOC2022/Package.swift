// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC2022",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
    ],
    products: [
        .library(
            name: "AOC2022",
            targets: ["AOC2022"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AOC2022",
            dependencies: [],
            resources: [.process("Inputs")]),
        .testTarget(
            name: "AOC2022Tests",
            dependencies: ["AOC2022"]),
    ]
)
