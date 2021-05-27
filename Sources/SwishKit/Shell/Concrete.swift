import Foundation

public struct ConcreteShellQuery<T: ShellOutputInitable>: ShellQuery {

	public typealias Output = T

	public let text: String
	public let shellRunner: ShellRunner

	public init(_ text: String, shellRunner: ShellRunner) {
		self.text = text
		self.shellRunner = shellRunner
	}
}

public struct ConcreteShellCommand: ShellCommand {
	public let text: String
	public let shellRunner: ShellRunner

	public init(_ text: String, shellRunner: ShellRunner) {
		self.text = text
		self.shellRunner = shellRunner
	}
}

public struct ConcreteBooleanShellQuery: BooleanShellQuery {
	public let shellRunner: ShellRunner

	public typealias Output = Bool
	public let text: String
	public let interpretation: BooleanStringInterpretation

	public init(_ text: String, interpretation: BooleanStringInterpretation, shellRunner: ShellRunner) {
		self.text = text
		self.interpretation = interpretation
		self.shellRunner = shellRunner
	}
}
