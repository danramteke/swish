import MPath
open class ConcreteShellCommand: ShellCommand {
	public let text: String
	public let shellRunner: ShellRunner
	public let workingDirectory: Path?
	public let environment: [String: String]?
	public let label: String?
	public let options: ShellOptions

	public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
							label: String? = nil,
							_ text: String,
							workingDirectory: Path? = nil,
							environment: [String: String]? = nil,
							options: ShellOptions = .default) {
		self.text = text
		self.workingDirectory = workingDirectory
		self.environment = environment
		self.label = label
		self.shellRunner = shellRunner
		self.options = options
	}
}
