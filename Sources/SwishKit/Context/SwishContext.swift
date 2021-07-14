import Foundation
import Logging
import MPath

public class SwishContext {
	let logger: Logger = Logger(label: "Swish.default")
	public let shellRunner: ShellRunner
	public private(set) var targetResolver: TargetResolver

	private let settings: Settings
	public init(settings: Settings = Settings()) {
		self.settings = settings
		self.shellRunner = ShellRunner(
			logDirectory: settings.sessionLogsDirectory,
			logLevel: settings.logLevel)
		self.targetResolver = TargetResolver(logLevel: settings.logLevel)

		if settings.isClearingPreviousLogsOnNewSession {
			try? settings.rootLogsDirectory.delete()
		}
	}

	public convenience init(contextName: String = "default", isClearingPreviousLogsOnNewSession: Bool = true,
													rootLogsDirectory: Path = Path.current + Path("tmp/logs/default"),
													logLevel: Logging.Logger.Level = .debug) {
		let settings = Settings(
			contextName: contextName,
			isClearingPreviousLogsOnNewSession: isClearingPreviousLogsOnNewSession,
			rootLogsDirectory: rootLogsDirectory,
			logLevel: logLevel)
		self.init(settings: settings)
	}

	public func resolve<T: Target>(_ target: T) throws {
		try self.targetResolver.resolve(target)
	}
}
