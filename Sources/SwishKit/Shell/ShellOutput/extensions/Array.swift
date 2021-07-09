import Foundation

extension Array where Element: ShellOutputInitable & StdOutputInitable {
	public init(shellOutput: ShellOutput) throws {
		try self.init(stdOutput: try shellOutput.stdOutput())
	}

  public init(stdOutput: String) throws {
    self = try stdOutput.split(separator: "\n").map { String($0) }.map { try Element(stdOutput: $0) }
  }
}

