import Foundation

public protocol ParsableShellQuery: ShellRunnable, Query {
	func parse(shellOutput: String) throws -> Output
}

extension ParsableShellQuery {
	public var usesStdOut: Bool { true }
	
	public func execute() throws -> Output {
		let output = try runShell()
		return try self.parse(shellOutput: output)
	}

	public func callAsFunction() throws -> Output {
		try execute()
	}
}
