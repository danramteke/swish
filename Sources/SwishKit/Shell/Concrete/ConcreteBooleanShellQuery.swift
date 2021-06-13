open class ConcreteBooleanShellQuery: BooleanShellQuery {
	public let shellRunner: ShellRunner

	public typealias Output = Bool
	public let text: String
	public let interpretation: BooleanStringInterpretation
	public let environment: [String: String]?
	public let label: String? 

	public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
							label: String? = nil,
							_ text: String,
							_ interpretation: BooleanStringInterpretation,
							environment: [String: String]? = nil) {
		self.text = text
		self.interpretation = interpretation
		self.environment = environment
		self.label = label
		self.shellRunner = shellRunner
	}
}
