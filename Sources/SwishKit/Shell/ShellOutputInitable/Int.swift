extension Int: ShellOutputInitable {
	public init(shellOutput: String) throws {
		let trimmedOutput = shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
		guard let value = Int(trimmedOutput) else {
			throw ShellOutputInitableIntParseError()
		}
		
		self = value
	}
}

public struct ShellOutputInitableIntParseError: Error { }
