import Foundation

public protocol ParsableShellQuery: Query {
	var text: String { get }
	func parse(shellOutput: String) throws -> Output
}

extension ParsableShellQuery {
	public func execute() throws -> Output {
		let output = try SharedShellHelper.execute(text: text)
		return try self.parse(shellOutput: output)
	}

	public func callAsFunction() throws -> Output {
		try execute()
	}
}
