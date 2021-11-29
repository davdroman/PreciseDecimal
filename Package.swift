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
        .library(name: "PreciseDecimal", targets: ["PreciseDecimal"]),
    ],
    targets: [
        .target(
            name: "PreciseDecimal"
        ),
        .testTarget(
            name: "PreciseDecimalTests",
            dependencies: [
                .target(name: "PreciseDecimal"),
                .product(name: "XCTJSONKit", package: "XCTJSONKit"),
            ]
        ),
    ]
)

package.dependencies = [
    .package(name: "XCTJSONKit", url: "https://github.com/davdroman/XCTJSONKit", .branch("main")),
]
