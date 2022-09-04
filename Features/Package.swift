// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "MoodyFeature",
            targets: ["MoodyFeature"]),
    ],
    targets: [
        .target(
            name: "MoodyFeature",
            dependencies: []
        ),
        .testTarget(
            name: "MoodyFeatureTests",
            dependencies: ["MoodyFeature"]
        )
    ]
)
