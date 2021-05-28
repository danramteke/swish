extension Int: ShellOutputInitable {

    public init(shellOutput: ShellOutput) throws {
        try self.init(stdOutput: try shellOutput.stdOutput())
	}
}


extension Int: StdOutputInitable {

    public init(stdOutput: String) throws {
        let trimmedOutput = stdOutput.trimmingCharacters(in: .whitespacesAndNewlines)

        guard let value = Int(trimmedOutput) else {
            throw StdOutputInitableIntParseError()
        }

        self = value
    }
}

public struct StdOutputInitableIntParseError: Error { }
