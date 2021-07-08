import Foundation

public protocol ShellRunnable {
	var text: String { get }
	var shellRunner: ShellRunner { get }

	var environment: [String: String]? { get }
	var label: String? { get }

    var options: ShellOptions { get }
}

extension ShellRunnable {

	public func runShell() throws -> ShellOutput {
		try shellRunner.execute(runnable: self)
	}

	public var environment: [String: String]? { nil }
}
