import Foundation

public struct ShellQuery<T: ShellOutputInitable>: Query {
	let text: String
	
	public init(_ text: String) {
		self.text = text
	}
	
	public func execute() -> Result<T, Error> {
		print("print running:".blue, text)
		return Result {
			try T.init(shellOutput: "Hello")
		}
	}

	public func callAsFunction() -> Result<T, Error> {
		return execute()
	}
}
