// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Pin",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "Pin", targets: ["Pin"]),
    ],
    targets: [
        .target(name: "Pin"),
        .testTarget(name: "PinTests", dependencies: ["Pin"]),
    ]
)
