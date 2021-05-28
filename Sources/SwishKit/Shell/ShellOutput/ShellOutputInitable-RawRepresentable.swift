extension RawRepresentable where RawValue == String {
	public init(shellOutput: String) throws {
		let trimmedOutput = shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		guard let value = Self.init(rawValue: trimmedOutput) else {
			throw ShellOutputInitableRawRepresentableParseError()
		}
		self = value
	}
}

public struct ShellOutputInitableRawRepresentableParseError: Error { }
