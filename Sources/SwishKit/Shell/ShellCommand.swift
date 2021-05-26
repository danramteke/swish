import Foundation
import Rainbow

public struct ShellCommand: Command {
	let text: String

	public init(_ text: String) {
		self.text = text
	}

	public func execute() -> Result<Void, Error> {
		print("print running:".blue, text)
		return .success(())
	}

	public func callAsFunction() -> Result<Void, Error> {
		execute()
	}
}
