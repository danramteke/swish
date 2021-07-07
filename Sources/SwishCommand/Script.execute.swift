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
		case .swiftTarget(let swiftTarget):
			announce(swiftTarget: swiftTarget)

            let argString: String = {
                return swiftTarget.arguments ?? ""
            }()
            try self.execute(text: "swift run \(swiftTarget.target) \(argString)", in: directory + Path(swiftTarget.path))
		}
	}

	private func announce(swiftTarget: SwiftTarget) {
		print()
		print("Running `\(swiftTarget.target)` at \(swiftTarget.path)")
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
