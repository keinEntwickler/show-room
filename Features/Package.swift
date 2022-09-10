// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(
            name: "MoodyFeature",
            targets: ["MoodyFeature"]
        )
    ],
    targets: [
        .target(
            name: "MoodyFeature",
            dependencies: [],
            plugins: [.plugin(name: "SwiftLintPlugin")]
        ),
        .testTarget(
            name: "MoodyFeatureTests",
            dependencies: ["MoodyFeature"],
            plugins: [.plugin(name: "SwiftLintPlugin")]
        ),
        .plugin(
            name: "SwiftLintPlugin",
            capability: .buildTool()
        )
    ]
)
