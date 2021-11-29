// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PreciseDecimal",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(
            name: "PreciseDecimal",
            targets: ["PreciseDecimal"]
        ),
    ],
    targets: [
        .target(
            name: "PreciseDecimal",
            dependencies: []
        ),
        .testTarget(
            name: "PreciseDecimalTests",
            dependencies: ["PreciseDecimal"]
        ),
    ]
)
