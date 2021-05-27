import Foundation

public protocol ShellQuery: Query where Output: ShellOutputInitable {
	var text: String { get }
}

extension ShellQuery {
	public func execute() -> Result<Output, Error> {
		print("print running:".blue, text)
		return Result {
			try Output.init(shellOutput: "Hello")
		}
	}

	public func callAsFunction() -> Result<Output, Error> {
		execute()
	}
}
