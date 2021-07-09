import Foundation

public protocol StdOutputInitable: ShellOutputInitable {
	init(stdOutput: String) throws
}

extension StdOutputInitable {
	public init(shellOutput: ShellOutput) throws {
		try self.init(stdOutput: try shellOutput.stdOutput())
	}
}
