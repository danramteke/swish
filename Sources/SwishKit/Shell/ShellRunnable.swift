import Foundation

public protocol ShellRunnable {
	var text: String { get }
	var shellRunner: ShellRunner { get }

	var environment: [String: String]? { get }
	var label: String? { get }

	var usesStdOut: Bool { get }
}

extension ShellRunnable {
	public func runShell() throws -> String {
		try shellRunner.execute(runnable: self)
	}

	public var environment: [String: String]? { nil }
	public var label: String? { nil }

	public var usesStdOut: Bool { false }
}
