import Foundation
import MPath

extension ShellRunner {
	public struct Settings {

		public let isClearingPreviousLogsOnNewSession: Bool
		public let rootLogsDirectory: Path
		public let isQuietLogging: Bool
		let sessionStartDate: Date = Date()

		public init(isClearingPreviousLogsOnNewSession: Bool = true,
								rootLogsDirectory: Path = Path.current + Path("tmp/logs"),
								isQuietLogging: Bool = false
		) {
			self.isClearingPreviousLogsOnNewSession = isClearingPreviousLogsOnNewSession
			self.rootLogsDirectory = rootLogsDirectory
			self.isQuietLogging = isQuietLogging
		}

		var sessionLogsDirectory: Path {
			rootLogsDirectory + Path(Self.dateFormatter.string(from: sessionStartDate))
		}

		private static let dateFormatter = DirectoryDateFormatter()
	}
}
