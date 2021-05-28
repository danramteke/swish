import MPath

extension Path: ShellOutputInitable {

	public init(shellOutput: ShellOutput) throws {
		self.init(try shellOutput.stdOutput())
	}
}

extension Path: StdOutputInitable {

    public init(stdOutput: String) {
        self.init(stdOutput.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
