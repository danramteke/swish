import Foundation
import Rainbow

public protocol ShellCommand: Command {
	var text: String { get }
}

extension ShellCommand {
	public func execute() -> Result<Void, Error> {
		print("print running:".blue, text)
		return .success(())
	}

	public func callAsFunction() -> Result<Void, Error> {
		execute()
	}
}
