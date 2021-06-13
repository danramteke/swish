import Logging

public struct TargetResolverLogger {

	private let logger: Logger
	public init(logLevel: Logging.Logger.Level) {
		var logger = Logger(label: "Target")
		logger.logLevel = logLevel
		self.logger = logger
	}

	func startResolution(of targetName: String, dependsOn: [String]) {
		let dependsOnJoined = dependsOn.joined(separator: ", ")
		logger.info("Resolving: \(targetName), depends on: \(dependsOnJoined)")
	}

	func running(_ targetName: String) {
		logger.info("Running \(targetName)")
	}

	func skipping(_ targetName: String) {
		logger.info("Nothing to run for \(targetName). Skipping.")
	}

	func alreadyResolved(_ targetName: String) {
		logger.debug("Already resolved \(targetName). Skipping.")
	}
}
