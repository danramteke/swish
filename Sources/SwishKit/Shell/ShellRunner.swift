import Foundation
import MPath

public class ShellRunner {
	let rootLogsDirectory: Path
	let sessionLogsDirectory: Path
	public init(logsDirectory: Path, clearPreviousLogs: Bool = true) {
		self.rootLogsDirectory = logsDirectory
		self.sessionLogsDirectory = logsDirectory + Path(Self.dateFormatter.string(from: Date()))

		if clearPreviousLogs {
			try? logsDirectory.delete()
		}
	}

	private var count = 0

	private static let dateFormatter: DateFormatter = {
		let df = DateFormatter()
		df.dateFormat = "YYYY-MM-dd'T'HHmmss"
		return df
	}()

	public func execute(runnable: ShellRunnable) throws -> String {
		defer {
			count += 1
		}
		try sessionLogsDirectory.createDirectories()
		let logDirectoryName = [String(format: "%02d", count), runnable.label].compactMap({$0}).joined(separator: "-")
		let logsDirectory = sessionLogsDirectory + Path(logDirectoryName)

		let stdout = logsDirectory + Path("stdout.log")
		try stdout.createEmptyFile()
		let stderr = logsDirectory + Path("stderr.log")
		try stderr.createEmptyFile()

		let stdoutHandle = try stdout.fileHandleForWriting()
		let stderrHandle = try stdout.fileHandleForWriting()

		defer {
			try! stdoutHandle.close()
			try! stderrHandle.close()
		}


		print("Running".red, runnable.text.cyan)

		let process = Process()
		process.executableURL = URL(fileURLWithPath: "/bin/sh")
		process.environment = ProcessInfo.processInfo.environment//runnable.environment
		process.arguments = ["-c", runnable.text]
		process.standardOutput = stdoutHandle
		process.standardError = stderrHandle
		try process.run()
		process.waitUntilExit()
		if 0 != process.terminationStatus {
			throw NonZeroShellTermination(status: process.terminationStatus)
		}

		if runnable.usesStdOut {
			return try stdout.read(encoding: .utf8)
		} else {
			return String()
		}
	}

	public struct NonZeroShellTermination: Error {
		public let status: Int32
	}
}
