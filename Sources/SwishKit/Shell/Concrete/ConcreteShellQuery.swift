open class ConcreteShellQuery<T: ShellOutputInitable>: ShellQuery {

	public typealias Output = T

	public let text: String
	public let shellRunner: ShellRunner

	public init(_ text: String, shellRunner: ShellRunner = SharedShellRunner) {
		self.text = text
		self.shellRunner = shellRunner
	}
}
