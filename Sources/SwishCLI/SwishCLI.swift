import ArgumentParser
import SwishDescription
import MPath
import Foundation

public struct SwishCLI: ParsableCommand {

	@Option(name: .shortAndLong, help: "The path to the Swish file. Can be relative or absolute.")
	public var file: Path?

	@Argument(help: "Name of script to run in the Swish file")
	public var script: String

	public mutating func run() throws {
        let manifestPath = try
            ManifestLocator().locate(commandLineArgument: file)

        let swishDescription: Swish = try
            ManifestFormat.detect(at: manifestPath)

		guard let script = swishDescription.scripts[self.script] else {
            throw ActionNotFoundInFileError(action: self.script)
		}

		let runner = ManifestScriptRunner(script: script,
																			workingDirectory: manifestPath.parent(),
																			logsDirectory: manifestPath.parent() + Path("tmp/logs/SwishCLI"))
			try runner.run()
	}

	public init() {}
}

struct FileNotFoundError: Error {}
struct ManifestFormatError: Error {}
struct ActionNotFoundInFileError: Error {
    let action: String
}
