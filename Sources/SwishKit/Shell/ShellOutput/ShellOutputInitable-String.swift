extension String: ShellOutputInitable {
	public init(shellOutput: String) throws {
		self = shellOutput.trimmingCharacters(in: .whitespacesAndNewlines)
	}
}