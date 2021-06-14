import ArgumentParser
import MPath

public struct SwishCommand: ParsableCommand {

	@Option(name: .shortAndLong, help: "The path to use.")
	public var file: Path?

	@Argument(help: "script to run in the Scripts dictionary")
	public var script: String

	public mutating func run() throws {
		let loadedFile = try loadFileOrThrow()

		guard let ext = loadedFile.extension, let format = SupportedFormat(rawValue: ext) else {
			throw UnsuportedExtensionError()
		}

		let description = try format.load(path: loadedFile)

		guard let script = description.scripts[self.script] else {
			throw ActionNotFoundInFileError()
		}

		try script.run()
	}

	private func loadFileOrThrow() throws -> Path {
		if let commandLineFile = file, commandLineFile.exists {
			return commandLineFile
		} else {
			return try defaultFileOrThrow()
		}
	}

	private func defaultFileOrThrow() throws -> Path {
		if Path("Scripts.swift").exists { 
			return Path("Scripts.swift") 
		} else if Path("Scripts.json").exists {
			return Path("Scripts.json")
		} else if Path("Scripts.yaml").exists {
			return Path("Scripts.yaml")
		} else if Path("Scripts.yml").exists {
			return Path("Scripts.yml")
		} else {
			throw FileNotFoundError()
		}
	}

	public init() {}
}

struct FileNotFoundError: Error {}
struct UnsuportedExtensionError: Error {}
struct ActionNotFoundInFileError: Error {}
