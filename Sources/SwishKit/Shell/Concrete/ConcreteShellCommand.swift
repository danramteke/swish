open class ConcreteShellCommand: ShellCommand {
	public let text: String
	public let shellRunner: ShellRunner
	public let environment: [String: String]?

	public init(_ text: String, environment: [String: String]? = nil, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.environment = environment
		self.shellRunner = shellRunner
	}
}
