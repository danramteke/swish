import ArgumentParser
import MPath

public struct SwishCommand: ParsableCommand {

	@Option(name: .shortAndLong, help: "The path to use.")
	public var file: Path = Path.current + Path("Scripts.swift")

	@Argument(help: "script to run in the Scripts dictionary")
	public var script: String

	public mutating func run() throws {
		guard file.exists else {
			throw FileNotFoundExtension()
		}

		guard let ext = file.extension, let format = SupportedFormat(rawValue: ext) else {
			throw UnsuportedExtensionError()
		}

		let description = try format.load(path: file)
		guard let script = description.scripts[self.script] else {
			throw ActionNotFoundInFileError()
		}

		try script.execute()
	}

	public init() {}
}

struct FileNotFoundExtension: Error {}
struct UnsuportedExtensionError: Error {}
struct ActionNotFoundInFileError: Error {}
