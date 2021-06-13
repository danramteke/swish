import Foundation
import Logging
import MPath

extension SwishContext {
	public struct Settings {

		public let contextName: String
		public let isClearingPreviousLogsOnNewSession: Bool
		public let rootLogsDirectory: Path
		public let logLevel: Logging.Logger.Level
		let sessionStartDate: Date = Date()

		public init(contextName: String = "default",
								isClearingPreviousLogsOnNewSession: Bool = true,
								rootLogsDirectory: Path = Path.current + Path("tmp/logs"),
								logLevel: Logging.Logger.Level = .debug
		) {
			self.contextName = contextName
			self.isClearingPreviousLogsOnNewSession = isClearingPreviousLogsOnNewSession
			self.rootLogsDirectory = rootLogsDirectory
			self.logLevel = logLevel
		}

		var sessionLogsDirectory: Path {
			rootLogsDirectory + Path(Self.dateFormatter.string(from: sessionStartDate) + "-\(contextName)")
		}

		private static let dateFormatter = DirectoryDateFormatter()
	}
}
