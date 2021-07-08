import ArgumentParser
import SwishDescription
import MPath

public struct SwishCommand: ParsableCommand {

	@Option(name: .shortAndLong, help: "The path to the Swish file. Can be relative or absolute.")
	public var file: Path?

	@Argument(help: "Name of script to run in the Swish file")
	public var script: String

	public mutating func run() throws {
        let manifestPath = try ManifestLocator().locate(commandLineArgument: file) 

		guard let ext = manifestPath.extension, let format = SupportedFormat(rawValue: ext) else {
			throw UnsupportedExtensionError()
		}

		let swishDescription: Swish = try format.load(path: manifestPath)

		guard let script = swishDescription.scripts[self.script] else {
            throw ActionNotFoundInFileError(action: self.script)
		}

		try script.run(in: manifestPath.parent())
	}

	public init() {}
}

struct FileNotFoundError: Error {}
struct UnsupportedExtensionError: Error {}
struct ActionNotFoundInFileError: Error {
    let action: String
}
