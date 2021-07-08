open class ConcreteBooleanShellQuery: BooleanShellQuery {
    public typealias Output = Bool

	public let shellRunner: ShellRunner
    public let label: String?
	public let text: String
	public let interpretation: BooleanStringInterpretation
	public let environment: [String: String]?
    public let options: ShellOptions

	public init(shellRunner: ShellRunner = SwishContext.default.shellRunner,
							label: String? = nil,
							_ text: String,
							_ interpretation: BooleanStringInterpretation,
							environment: [String: String]? = nil,
                            options: ShellOptions = .default) {
		self.text = text
		self.interpretation = interpretation
		self.environment = environment
		self.label = label
		self.shellRunner = shellRunner
        self.options = options
	}
}
