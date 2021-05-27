import Foundation

public protocol ShellQuery: Query where Output: ShellOutputInitable {
	var text: String { get }
}

extension ShellQuery {
	public func execute() throws -> Output {
		let output = try SharedShellHelper.execute(text: text)
		return try Output.init(shellOutput: output)
	}

	public func callAsFunction() throws -> Output {
		try execute()
	}
}
