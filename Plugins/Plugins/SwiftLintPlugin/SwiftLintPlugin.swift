import Foundation
import PackagePlugin

@main
struct SwiftLintPlugin: BuildToolPlugin {
    func createBuildCommands(context: PluginContext, target: Target) async throws -> [Command] {
        [
            .lint(
                displayName: target.name,
                executable: try context.tool(named: "swiftlint").path,
                path: target.directory.string,
                workDirectory: context.pluginWorkDirectory
            )
        ]
    }
}

#if canImport(XcodeProjectPlugin)
import XcodeProjectPlugin

extension SwiftLintPlugin: XcodeBuildToolPlugin {
    func createBuildCommands(context: XcodePluginContext, target: XcodeTarget) throws -> [Command] {
        [
            .lint(
                displayName: target.displayName,
                executable: try context.tool(named: "swiftlint").path,
                path: context.xcodeProject.directory.string,
                workDirectory: context.pluginWorkDirectory
            )
        ]
    }
}
#endif

extension Command {

    static func lint(
        displayName: String,
        executable: Path,
        path: String,
        workDirectory: Path
    ) -> Self {
        .buildCommand(
            displayName: "Running SwiftLint for \(displayName)",
            executable: executable,
            arguments: [
                "lint",
                path,
                "--config",
                swiftLintConfigPath,
                "--cache-path",
                "\(workDirectory.string)/cache"
            ]
        )
    }
}

// MARK: - Config

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

    let path = String(
        data: pipe.fileHandleForReading.readDataToEndOfFile(),
        encoding: String.Encoding.utf8
    )!.trimmingCharacters(in: .whitespacesAndNewlines)

    Diagnostics.remark(
        "> " + path
    )

    return path
}
