import Foundation

public protocol ParsableShellQuery: ShellRunnable, Query {
	func parse(string: String) throws -> Output
}

extension ParsableShellQuery {
	
	public func execute() throws -> Output {
		let string = try runShell().stdOutput()
		return try self.parse(string: string)
	}

	public func callAsFunction() throws -> Output {
		try execute()
	}
}
