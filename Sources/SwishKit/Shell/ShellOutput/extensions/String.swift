extension String: ShellOutputInitable {}
extension String: StdOutputInitable {
	public init(stdOutput: String) throws {
		self = stdOutput.trimmingCharacters(in: .whitespacesAndNewlines)
	}
}
