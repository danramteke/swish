import Foundation

public protocol ShellRunnable {
	var text: String { get }
	var shellRunner: ShellRunner { get }

	var environment: [String: String]? { get }
	var label: String? { get }
}

extension ShellRunnable {

	public func runShell() throws -> ShellOutput {
		try shellRunner.execute(runnable: self)
	}

	public var environment: [String: String]? { nil }
	public var label: String? { nil }
}