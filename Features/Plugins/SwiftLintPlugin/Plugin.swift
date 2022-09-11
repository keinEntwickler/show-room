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
                executable: swiftlintPath,
                arguments: [
                    "--config",
                    swiftLintConfigPath,
                    target.directory.string
                ],
                outputFilesDirectory: context.pluginWorkDirectory
            )
        ]
    }
}

let swiftlintPath: PackagePlugin.Path = {
    // TODO: Better approach wohld be to handle it through swift package!
    let path = process(
        executablePath: "/usr/bin/which",
        arguments: ["swiftlint"]
    )

    if path.isEmpty {
        Diagnostics.error("SwiftLint not installed, download from https://github.com/realm/SwiftLint")
    }
    
    return .init(path)
}()

let swiftLintConfigPath: String = {
    process(
        executablePath: "/usr/bin/git",
        arguments: ["rev-parse", "--show-toplevel"]
    ) + "/.swiftlint.yml"
}()

func process(
    executablePath: String,
    arguments: [String]
) -> String {
    let process = Process()
    process.executableURL = .init(fileURLWithPath: executablePath)
    process.arguments = arguments
    
    let pipe = Pipe()
    process.standardOutput = pipe
    try! process.run()
    process.waitUntilExit()
    
    return String(
        data: pipe.fileHandleForReading.readDataToEndOfFile(),
        encoding: String.Encoding.utf8
    )!.trimmingCharacters(in: .whitespacesAndNewlines)
}
