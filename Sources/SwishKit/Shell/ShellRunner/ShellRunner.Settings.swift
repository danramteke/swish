import Foundation
import MPath

extension ShellRunner {
	public struct Settings {

		public let isClearingPreviousLogsOnNewSession: Bool
		public let rootLogsDirectory: Path
		let sessionStartDate: Date = Date()

		public init(isClearingPreviousLogsOnNewSession: Bool = true,
								rootLogsDirectory: Path = Path.current + Path(".swish/logs")
		) {
			self.isClearingPreviousLogsOnNewSession = isClearingPreviousLogsOnNewSession
			self.rootLogsDirectory = rootLogsDirectory
		}

		var sessionLogsDirectory: Path {
			rootLogsDirectory + Path(Self.dateFormatter.string(from: sessionStartDate))
		}

		private static let dateFormatter = DirectoryDateFormatter()
	}
}
