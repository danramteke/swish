import Foundation
import MPath

public class ShellRunner {
	lazy var logger = ConsoleLogger(isQuiet: settings.isQuietLogging)

	public var settings: Settings = Settings() {
		didSet {
			if isStarted.value {
				logger.warnChangingSettingsAfterStart()
			}
		}
	}

	public init() {}

	private let count = AtomicValue(initial: 0, label: "ShellRunner.count")
	private let isStarted = AtomicValue(initial: false, label: "ShellRunner.isStarted")

	public func execute(runnable: ShellRunnable) throws -> ShellOutput {

		isStarted.switchOn {
			if settings.isClearingPreviousLogsOnNewSession {
				try? settings.rootLogsDirectory.delete()
			}
		}

		let count: Int = count.claim()

		let logDirectoryName = [String(format: "%03d", count), runnable.label].compactMap({$0}).joined(separator: "-")
		let logsDirectory = settings.sessionLogsDirectory + Path(logDirectoryName)
		try logsDirectory.createDirectories()

		let stdout = logsDirectory + Path("stdout.log")
		try stdout.createEmptyFile()
		let stderr = logsDirectory + Path("stderr.log")
		try stderr.createEmptyFile()
		let cmdout = logsDirectory + Path("cmd.log")
		try cmdout.write(runnable.text, encoding: .utf8)

		let stdoutHandle = try stdout.fileHandleForWriting()
		let stderrHandle = try stdout.fileHandleForWriting()

		logger.start(label: "Running", message: runnable.text)


		let process = Process()
		process.executableURL = URL(fileURLWithPath: "/bin/sh")
		process.environment = combineEnvironments(base: ProcessInfo.processInfo.environment,
																							overrides: runnable.environment)
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
