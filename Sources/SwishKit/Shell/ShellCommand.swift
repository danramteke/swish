import Foundation
import Rainbow

public protocol ShellCommand: Command {
	var text: String { get }
}

extension ShellCommand {
	public func execute() throws {
		_ = try SharedShellHelper.execute(text: text)
	}

	public func callAsFunction() throws {
		try execute()
	}
}
