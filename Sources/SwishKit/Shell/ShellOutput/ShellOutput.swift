import MPath

public struct ShellOutput {
	public let stdOut: ShellOutput.LogStatus
	public let stdErr: ShellOutput.LogStatus
	public let status: Int32

	public enum LogStatus {
		case empty
		case present(Path)

		public func read() throws -> String {
			switch self {
			case .empty:
				throw TriedToReadOutputFileWhenThereWasNoOutput()
			case .present(let path):
				return try path.read(encoding: .utf8)
			}
		}
	}
}

extension ShellOutput {
	public func stdOutput() throws -> String {
		try stdOut.read()
	}

	public func stdError() throws -> String {
		try stdErr.read()
	}
}

struct TriedToReadOutputFileWhenThereWasNoOutput: Error { }
