open class ConcreteBooleanShellQuery: BooleanShellQuery {
	public let shellRunner: ShellRunner

	public typealias Output = Bool
	public let text: String
	public let interpretation: BooleanStringInterpretation
	public let environment: [String: String]?

	public init(_ text: String, _ interpretation: BooleanStringInterpretation, environment: [String: String]? = nil, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.interpretation = interpretation
		self.environment = environment
		self.shellRunner = shellRunner
	}
}
