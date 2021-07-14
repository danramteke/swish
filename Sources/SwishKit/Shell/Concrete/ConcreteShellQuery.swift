import MPath

open class ConcreteShellQuery<T: ShellOutputInitable>: ShellQuery {

	public typealias Output = T

	public let text: String
	public let shellRunner: ShellRunner
	public let workingDirectory: Path?
	public let environment: [String: String]?
	public let label: String? 
	public var options: ShellOptions

	public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
							label: String? = nil,
							_ text: String,
							workingDirectory: Path? = nil,
							environment: [String: String]? = nil,
							options: ShellOptions = .default) {
		self.text = text
		self.environment = environment
		self.label = label
		self.workingDirectory = workingDirectory
		self.shellRunner = shellRunner
		self.options = options
	}
}
