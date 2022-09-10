import PackagePlugin
import Foundation

@main
struct SwiftLintPlugin: BuildToolPlugin {

    func createBuildCommands(
        context: PluginContext,
        target: Target
    ) async throws -> [Command] {
        [
            .prebuildCommand(
                displayName: "SwiftLintPlugin",
                executable: try Self.swiftlint(),
                arguments: [
                    "--config",
                    try Self.swiftLintConfig(),
                    FileManager.default.currentDirectoryPath
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}

private extension SwiftLintPlugin {

    static func swiftlint() throws -> PackagePlugin.Path {
        let process = Process()
        // TODO: has to be installed
        // Better approach wohld be to handle it through swift package!
        process.executableURL = .init(fileURLWithPath: "/usr/bin/which")
        process.arguments = ["swiftLint"]

        let pipe = Pipe()
        process.standardOutput = pipe
        try process.run()
        process.waitUntilExit()

        let output = String(
            data: pipe.fileHandleForReading.readDataToEndOfFile(),
            encoding: String.Encoding.utf8
        )!

        return .init(output.trimmingCharacters(in: .whitespacesAndNewlines))
    }

    static func swiftLintConfig() throws -> String {
        let process = Process()
        process.executableURL = .init(fileURLWithPath: "/usr/bin/git")
        process.arguments = ["rev-parse", "--show-toplevel"]

        let pipe = Pipe()
        process.standardOutput = pipe
        try process.run()
        process.waitUntilExit()

        let output = String(
            data: pipe.fileHandleForReading.readDataToEndOfFile(),
            encoding: String.Encoding.utf8
        )!.trimmingCharacters(in: .whitespacesAndNewlines)

        // TODO: check if it is used ...
        return output + "/.swiftlint.yml"
    }
}
