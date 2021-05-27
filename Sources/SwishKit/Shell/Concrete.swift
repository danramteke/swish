import Foundation

open class ConcreteShellQuery<T: ShellOutputInitable>: ShellQuery {

	public typealias Output = T

	public let text: String
	public let shellRunner: ShellRunner

	public init(_ text: String, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.shellRunner = shellRunner
	}
}

open class ConcreteShellCommand: ShellCommand {
	public let text: String
	public let shellRunner: ShellRunner

	public init(_ text: String, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.shellRunner = shellRunner
	}
}

open class ConcreteBooleanShellQuery: BooleanShellQuery {
	public let shellRunner: ShellRunner

	public typealias Output = Bool
	public let text: String
	public let interpretation: BooleanStringInterpretation

	public init(_ text: String, interpretation: BooleanStringInterpretation, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.interpretation = interpretation
		self.shellRunner = shellRunner
	}
}
