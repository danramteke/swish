import Foundation
import Logging

class ConsoleLogger {
	let logger: Logger

	init(logLevel: Logging.Logger.Level) {
		var logger = Logger(label: "Swish")
		logger.logLevel = logLevel

		self.logger = logger
	}

	func warnChangingSettingsAfterStart() {
		let message: Logger.Message = "[Warning] editing settings after script has started is not supported"
		logger.warning(message)
	}

	func start(label: String, message: String) {

		let styledLabel = "[\(label)]"
		let styledMessage = "$ \(message)"
		let message: Logger.Message = "\(styledLabel) \(styledMessage)"

		logger.info(message)
	}

	func nonZeroTermination(cmd: String, stdout: String?, stderr: String?) {

		let label = "[non-zero termination]"
		let cmdLine = "$ \(cmd)"
		let stdoutLine = "(stdout)" + " " + (stdout ?? "<empty>")
		let stderrLine = "(stderr)" + " " + (stderr ?? "<empty>")

		let message: Logger.Message = "\(label)\n\(cmdLine)\n\(stdoutLine)\n\(stderrLine)"
		logger.error(message)
	}

	func startResolution(of targetName: String, dependsOn: [String]) {
		let dependsOnJoined = dependsOn.joined(separator: ", ")
		logger.info("Resolving: \(targetName), depends on: \(dependsOnJoined)")
	}

	func skipping(_ targetName: String) {
		logger.info("Skipping \(targetName), not needed")
	}

	func alreadyResolved(_ targetName: String) {
		logger.debug("Already resolved \(targetName). Skipping")
	}
}
