
open class ConcreteBooleanShellQuery: BooleanShellQuery {
	public let shellRunner: ShellRunner

	public typealias Output = Bool
	public let text: String
	public let interpretation: BooleanStringInterpretation

	public init(_ text: String, _ interpretation: BooleanStringInterpretation, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.interpretation = interpretation
		self.shellRunner = shellRunner
	}
}
