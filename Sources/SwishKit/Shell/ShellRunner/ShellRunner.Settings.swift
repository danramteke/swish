import Foundation
import MPath
import Logging

extension ShellRunner {
	public struct Settings {

		public let isClearingPreviousLogsOnNewSession: Bool
		public let rootLogsDirectory: Path
		public let logLevel: Logging.Logger.Level
		let sessionStartDate: Date = Date()

		public init(isClearingPreviousLogsOnNewSession: Bool = true,
								rootLogsDirectory: Path = Path.current + Path("tmp/logs"),
								logLevel: Logging.Logger.Level = .debug
		) {
			self.isClearingPreviousLogsOnNewSession = isClearingPreviousLogsOnNewSession
			self.rootLogsDirectory = rootLogsDirectory
			self.logLevel = logLevel
		}

		var sessionLogsDirectory: Path {
			rootLogsDirectory + Path(Self.dateFormatter.string(from: sessionStartDate))
		}

		private static let dateFormatter = DirectoryDateFormatter()
	}
}
