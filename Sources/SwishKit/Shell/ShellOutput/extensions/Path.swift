import MPath

extension Path: StdOutputInitable {

	public init(stdOutput: String) {
		self.init(stdOutput.trimmingCharacters(in: .whitespacesAndNewlines))
	}
}
