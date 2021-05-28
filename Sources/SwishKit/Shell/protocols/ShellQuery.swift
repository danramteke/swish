import Foundation

public protocol ShellQuery: ShellRunnable, Query where Output: ShellOutputInitable {
}

extension ShellQuery {

	public func execute() throws -> Output {
		let output = try self.runShell()
		return try Output.init(shellOutput: output)
	}

	public func callAsFunction() throws -> Output {
		try execute()
	}
}
