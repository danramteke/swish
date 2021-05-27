import Foundation

public protocol ParsableShellQuery: Query {
	var text: String { get }
	func parse(shellOutput: String) throws -> Output
}

extension ParsableShellQuery {
	public func execute() -> Result<Output, Error> {
		print("print running:".blue, text)
		return Result {
			try self.parse(shellOutput: "sample output")
		}
	}

	public func callAsFunction() -> Result<Output, Error> {
		execute()
	}
}
