import Foundation

public protocol ShellCommand: ShellRunnable, Command {
	var text: String { get }
}

extension ShellCommand {
	public func execute() throws {
		_ = try shellRunner.execute(runnable: self)
	}

	public func callAsFunction() throws {
		try execute()
	}
}
