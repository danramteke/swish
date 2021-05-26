import Foundation

public struct ConcreteShellQuery<T: ShellOutputInitable>: ShellQuery {
	public typealias Output = T

	public let text: String

	public init(_ text: String) {
		self.text = text
	}
}

public struct ConcreteShellCommand: ShellCommand {
	public let text: String

	public init(_ text: String) {
		self.text = text
	}
}
