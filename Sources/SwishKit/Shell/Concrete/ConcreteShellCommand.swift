open class ConcreteShellCommand: ShellCommand {
	public let text: String
	public let shellRunner: ShellRunner
	public let environment: [String: String]?
	public let label: String?

	public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
							label: String? = nil,
							_ text: String,
							environment: [String: String]? = nil) {
		self.text = text
		self.environment = environment
		self.label = label
		self.shellRunner = shellRunner
	}
}
