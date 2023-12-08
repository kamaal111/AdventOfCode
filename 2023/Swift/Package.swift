// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AOC2023",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "AOC2023",
            targets: ["AOC2023"]
        ),
        .library(
            name: "AOCTools",
            targets: ["AOCTools"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/Kamaalio/KamaalSwift.git", .upToNextMajor(from: "1.4.1")),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.2.0"),
    ],
    targets: [
        .target(
            name: "AOC2023",
            dependencies: [
                .product(name: "KamaalExtensions", package: "KamaalSwift"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                "AOCTools"
            ],
            resources: [.process("Inputs")]
        ),
        .target(
            name: "AOCTools",
            dependencies: []
        ),
        .testTarget(
            name: "AOC2023Tests",
            dependencies: ["AOC2023"]),
    ]
)
