import Foundation

public protocol StdOutputInitable {
    init(stdOutput: String) throws
}

extension ShellOutputInitable where Self:StdOutputInitable  {
    public init(shellOutput: ShellOutput) throws {
        try self.init(stdOutput: try shellOutput.stdOutput())
	}
}