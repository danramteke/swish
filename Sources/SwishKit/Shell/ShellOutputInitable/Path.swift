import MPath
extension Path: ShellOutputInitable {
	public init(shellOutput: String) throws {
		self.init(shellOutput.trimmingCharacters(in: .whitespacesAndNewlines))
	}
}
