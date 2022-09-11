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
                path,
                "--config",
                sourceRoot + "/.swiftlint.yml",
                "--no-cache"
                // not working on Xcode Cloud
                // "--cache-path",
                // "\(workDirectory.string)/cache"
            ]
        )
    }
}

// MARK: - Config

let sourceRoot: String = {
    process(
        executablePath: "/usr/bin/git",
        arguments: ["rev-parse", "--show-toplevel"]
    )
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
