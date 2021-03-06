import Foundation
import MPath
import SwishKit
import SwishDescription

enum CPUArch {
	case intel
	case arm

	var swiftRunArg: String {
		switch self {
		case .intel:
			return "--arch x86_64"
		case .arm:
			return "--arch arm64"
		}
	}

	static func detect() -> Self {

		let utsname = UnsafeMutablePointer<utsname>.allocate(capacity: MemoryLayout<utsname>.stride)
		uname(utsname)
		let machineTuple = utsname.pointee.machine
		utsname.deallocate()

		let machineCstring = Mirror(reflecting: machineTuple)
			.children
			.compactMap { $0.value as? Int8 }

		let machine = String(cString: machineCstring, encoding: .utf8)
		switch machine {
		case "arm64", "arm64e":
			return .arm
		default:
			return .intel
		}
	}
}

final class ManifestScriptRunner {

	let context: SwishContext
	let script: Script
	let workingDirectory: Path
	init(script: Script, workingDirectory: Path, logsDirectory: Path) {
		self.script = script
		self.workingDirectory = workingDirectory
		context = SwishContext(contextName: "SwishCLI", isClearingPreviousLogsOnNewSession: true, rootLogsDirectory: logsDirectory, logLevel: .info)
	}

	func run() throws {

		switch script {
		case .text(let text):
			announce(text: text)
			try execute(text: text, in: workingDirectory)
		case .swift(let swift):
			announce(swift: swift)

			let argString: String = swift.arguments ?? ""
			let arch = CPUArch.detect()

			let text = """
					swift run \
					--package-path \(swift.path) \
					\(arch.swiftRunArg) \
					\(swift.target) \
					\(argString)
					"""
			announce(text: text)
			try self.execute(text: text, in: workingDirectory)
		}
	}

	private func announce(swift: Swift) {
		print()
		print("Running `\(swift.target)` at \(swift.path)")
		print()
	}

	private func announce(text: String) {
		print()
		print("$ \(text)")
		print()
	}

	private func execute(text: String, in directory: Path) throws {
		// try context.sh(text, in: directory)

		let process = Process()
		process.executableURL = URL(fileURLWithPath: "/bin/sh")
		process.arguments = ["-c", text]
		process.currentDirectoryURL = directory.url

		process.standardOutput = FileHandle.standardOutput
		process.standardError = FileHandle.standardError
		try process.run()
		process.waitUntilExit()

		if 0 != process.terminationStatus {
			throw NonZeroShellTermination(status: process.terminationStatus)
		}
	}
}
