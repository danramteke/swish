import Foundation

public protocol ParsableShellQuery: ShellRunnable, Query {
	func parse(stdOutput: String) throws -> Output
}

extension ParsableShellQuery {
	
	public func execute() throws -> Output {
        let string = try runShell().stdOutput()
		return try self.parse(stdOutput: string)
	}

	public func callAsFunction() throws -> Output {
		try execute()
	}
}
