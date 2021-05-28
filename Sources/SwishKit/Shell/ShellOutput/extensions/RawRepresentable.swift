extension RawRepresentable where RawValue == String {

	public init(shellOutput: ShellOutput) throws {
		try self.init(stdOutput: try shellOutput.stdOutput())
	}
}

extension RawRepresentable where RawValue == String {

	public init(stdOutput: String) throws {
		let trimmedOutput = stdOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		guard let value = Self.init(rawValue: trimmedOutput) else {
			throw StdOutputInitableRawRepresentableParseError()
		}
		self = value
	}
}

public struct StdOutputInitableRawRepresentableParseError: Error { }
