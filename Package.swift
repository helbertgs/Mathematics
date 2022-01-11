// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Mathematics",
    products: [
        .library(
            name: "Mathematics",
            targets: ["Mathematics"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "Mathematics",
            dependencies: []),
        .testTarget(
            name: "MathematicsTests",
            dependencies: ["Mathematics"]),
    ]
)
