open class ConcreteShellCommand: ShellCommand {
	public let text: String
	public let shellRunner: ShellRunner

	public init(_ text: String, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.shellRunner = shellRunner
	}
}
