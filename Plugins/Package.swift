// swift-tools-version: 5.7

import PackageDescription

var package = Package(name: "Plugins")
package.platforms = [.iOS(.v15), .macOS(.v11)]

// MARK: - Products

package.products = [
    .plugin(name: "SwiftLintPlugin", targets: ["SwiftLintPlugin"])
]

// MARK: - Targets

package.targets = [
    .plugin(
        name: "SwiftLintPlugin",
        capability: .buildTool(),
        dependencies: ["SwiftLintBinary"]
    ),
    .binaryTarget(
        name: "SwiftLintBinary",
        url: "https://github.com/realm/SwiftLint/releases/download/0.49.1/SwiftLintBinary-macos.artifactbundle.zip",
        checksum: "227258fdb2f920f8ce90d4f08d019e1b0db5a4ad2090afa012fd7c2c91716df3"
    )
]
