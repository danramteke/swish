import SwishDescription
import Foundation
import MPath

extension Script {
	/// Run the script after changing directory to the Swish file.
	func run(in directory: Path) throws {
		switch self {
		case .text(let text):
			announce(text: text)
			try execute(text: text, in: directory)
		case .swishKit(let swishKitTarget):
			announce(swishKitTarget: swishKitTarget)
			try self.execute(text: "swift run \(swishKitTarget.target)", in: directory + Path(swishKitTarget.path))
		}
	}

	private func announce(swishKitTarget: SwishKitTarget) {
		print()
		print("Running `\(swishKitTarget.target)` at \(swishKitTarget.path)")
		print()
	}

	private func announce(text: String) {
		print()
		print("$ \(text)")
		print()
	}

	private func execute(text: String, in directory: Path) throws {
		let process = Process()
		process.executableURL = URL(fileURLWithPath: "/bin/sh")
		process.arguments = ["-c", "cd \(directory) && \(text)"]

		process.standardOutput = FileHandle.standardOutput
		process.standardError = FileHandle.standardError
		try process.run()
		process.waitUntilExit()

		if 0 != process.terminationStatus {
			throw NonZeroShellTermination(status: process.terminationStatus)
		}
	}
}

public struct NonZeroShellTermination: Error {
	public let status: Int32
}
