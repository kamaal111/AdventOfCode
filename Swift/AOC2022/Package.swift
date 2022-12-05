// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC2022",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "AOC2022",
            targets: ["AOC2022"]),
    ],
    dependencies: [
        .package(url: "https://github.com/kamaal111/ShrimpExtensions.git", "2.8.0"..<"3.0.0"),
        .package(url: "https://github.com/apple/swift-collections.git", "1.0.3"..<"2.0.0"),
        .package(url: "https://github.com/apple/swift-algorithms", "1.0.0"..<"2.0.0"),
        .package(url: "https://github.com/apple/swift-numerics", "1.0.0"..<"2.0.0"),
    ],
    targets: [
        .target(
            name: "AOC2022",
            dependencies: [
                "ShrimpExtensions",
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Numerics", package: "swift-numerics"),
            ],
            resources: [.process("Inputs")]),
        .testTarget(
            name: "AOC2022Tests",
            dependencies: ["AOC2022"]),
    ]
)
