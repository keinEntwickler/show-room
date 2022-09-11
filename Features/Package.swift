// swift-tools-version: 5.7

import PackageDescription

var package = Package(name: "Features")
package.platforms = [.iOS(.v16)]

// MARK: - Products

package.products = [
    .library(name: "MoodyFeature", targets: ["MoodyFeature"])
]

// MARK: - Dependencies

package.dependencies = [
    .package(path: "../Plugins")
]

// MARK: - Targets

package.targets = [
    .target(
        name: "SomeTest",
        dependencies: [],
        plugins: [.plugin(name: "SwiftLintPlugin", package: "Plugins")]
    ),
    .target(
        name: "MoodyFeature",
        dependencies: ["SomeTest"],
        plugins: [.plugin(name: "SwiftLintPlugin", package: "Plugins")]
    ),
    .testTarget(
        name: "MoodyFeatureTests",
        dependencies: ["MoodyFeature"],
        plugins: [.plugin(name: "SwiftLintPlugin", package: "Plugins")]
    )
]
