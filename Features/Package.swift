// swift-tools-version: 5.7

import PackageDescription

// MARK: - Targets

let targets: [Target] = [
    .target(
        name: "SomeTest",
        dependencies: [],
        plugins: [.plugin(name: "SwiftLintPlugin")]
    ),
    .target(
        name: "MoodyFeature",
        dependencies: ["SomeTest"],
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

// MARK: - Package

let package = Package(
    name: "Features",
    platforms: [.iOS(.v16)],
    products: [
        .library(name: "MoodyFeature", targets: ["MoodyFeature"]),
        .plugin(name: "SwiftLintPlugin", targets: ["SwiftLintPlugin"])
    ],
    targets: targets
)
