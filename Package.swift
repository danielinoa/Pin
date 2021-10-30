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
    dependencies: [
        .package(url: "https://github.com/danielinoa/SwiftPlus.git", .branch("main"))
    ],
    targets: [
        .target(name: "Pin", dependencies: ["SwiftPlus"]),
        .testTarget(name: "PinTests", dependencies: ["Pin"]),
    ]
)
