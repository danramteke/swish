extension String: ShellOutputInitable {
	public init(shellOutput: ShellOutput) throws {
        try self.init(stdOutput: try shellOutput.stdOutput())
    }
}

extension String: StdOutputInitable {
    public init(stdOutput: String) throws {
        self = stdOutput.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
