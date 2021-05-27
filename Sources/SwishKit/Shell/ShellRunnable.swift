import Foundation

public protocol ShellRunnable {
	var text: String { get }
	var shellRunner: ShellRunner { get }
}

extension ShellRunnable {
	public func runShell() throws -> String {
		try shellRunner.execute(text: text)
	}
}
