// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let excludedFilenames = ["README.md"]

let package = Package(
    name: "swift-math",
    products: [
        .library(name: "Math", targets: ["Math"]),
    ],
    dependencies: [ ],
    targets: [
        .target(
            name: "Math",
            dependencies: [],
            exclude: excludedFilenames
        ),

        .testTarget(
            name: "MathTests",
            dependencies: ["Math"],
            exclude: excludedFilenames
        ),
    ]
)