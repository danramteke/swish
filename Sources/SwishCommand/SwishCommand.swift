import ArgumentParser
import SwishDescription
import MPath

public struct SwishCommand: ParsableCommand {

	@Option(name: .shortAndLong, help: "The path to the Swish file. Can be relative or absolute.")
	public var file: Path?

	@Argument(help: "Name of script to run in the Swish file")
	public var script: String

	public mutating func run() throws {
		let loadedFile = try loadFileOrThrow()

		guard let ext = loadedFile.extension, let format = SupportedFormat(rawValue: ext) else {
			throw UnsupportedExtensionError()
		}

		let description: Swish = try format.load(path: loadedFile)

		guard let script = description.scripts[self.script] else {
			throw ActionNotFoundInFileError()
		}

		try script.run(in: loadedFile.parent())
	}

	private func loadFileOrThrow() throws -> Path {
		if let commandLineFile = file, commandLineFile.exists {
			return commandLineFile
		} else {
			return try defaultFileOrThrow()
		}
	}

	private func defaultFileOrThrow() throws -> Path {
		if Path("Swish.swift").exists { 
			return Path("Swish.swift") 
		} else if Path("Swish.json").exists {
			return Path("Swish.json")
		} else if Path("Swish.yaml").exists {
			return Path("Swish.yaml")
		} else if Path("Swish.yml").exists {
			return Path("Swish.yml")
		} else {
			throw FileNotFoundError()
		}
	}

	public init() {}
}

struct FileNotFoundError: Error {}
struct UnsupportedExtensionError: Error {}
struct ActionNotFoundInFileError: Error {}
