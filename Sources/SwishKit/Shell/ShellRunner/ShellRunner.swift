import Foundation
import MPath
import Logging

public class ShellRunner {
	let logger: ShellRunnerLogger
	let logDirectory: Path

	public init(logDirectory: Path, logLevel: Logging.Logger.Level) {
		self.logDirectory = logDirectory
		logger = ShellRunnerLogger(logLevel: logLevel)
	}

	private let count = AtomicValue(initial: 0, label: "ShellRunner.count")

	public func execute(runnable: ShellRunnable) throws -> ShellOutput {

		let runNumber: Int = count.claim()

		let logDirectoryName = [String(format: "%03d", runNumber), runnable.label]
			.compactMap { $0 }
			.joined(separator: "-")
		let logsDirectory = self.logDirectory + Path(logDirectoryName)
		try logsDirectory.createDirectories()

		let stdout = logsDirectory + Path("stdout.log")

		try stdout.createEmptyFile()
		let stderr = logsDirectory + Path("stderr.log")
		try stderr.createEmptyFile()
		let cmdout = logsDirectory + Path("cmd.log")
		try cmdout.write(runnable.text, encoding: .utf8)

		let stdoutHandle = try stdout.fileHandleForWriting()
		let stderrHandle = try stdout.fileHandleForWriting()

		if runnable.options.contains(.console) {
			logger.start(label: runnable.label, message: runnable.text)
		}

		let process = Process()
		process.executableURL = URL(fileURLWithPath: "/bin/sh")
		process.environment = combineEnvironments(base: ProcessInfo.processInfo.environment,
																							overrides: runnable.environment)
		if let workingDirectory = runnable.workingDirectory {
			process.currentDirectoryURL = workingDirectory.url
		}
		process.arguments = ["-c", runnable.text]
		process.standardOutput = stdoutHandle
		process.standardError = stderrHandle
		try process.run()
		process.waitUntilExit()

		try stdoutHandle.close()
		try stderrHandle.close()

		let stdoutLogStatus: ShellOutput.LogStatus = try logStatus(for: stdout)
		let stderrLogStatus: ShellOutput.LogStatus = try logStatus(for: stderr)

		if 0 != process.terminationStatus {
			logger.nonZeroTermination(cmd: runnable.text,
																stdout: stdoutLogStatus.path?.string,
																stderr: stderrLogStatus.path?.string)
			throw NonZeroShellTermination(status: process.terminationStatus)
		}

		return ShellOutput(
			cmdOut: cmdout,
			stdOut: stdoutLogStatus,
			stdErr: stderrLogStatus,
			status: process.terminationStatus
		)
	}

	public struct NonZeroShellTermination: Error {
		public let status: Int32
	}

	private func logStatus(for path: Path) throws -> ShellOutput.LogStatus {
		if try path.isEmpty() {
			try path.delete()
			return .empty
		} else {
			return .present(path)
		}
	}

	private func combineEnvironments(base maybeBase: [String: String]?, overrides maybeOverrides: [String: String]?) -> [String: String]? {
		guard let base = maybeBase else {
			return maybeOverrides
		}

		guard let overrides = maybeOverrides else {
			return base
		}

		var copy = base

		for pair in overrides {
			copy[pair.key] = pair.value
		}

		return copy
	}
}
