import Foundation
import MPath

extension ShellRunner {
	public func cmd(label: String? = nil, _ text: String, env: [String: String]? = nil) -> ShellCommand {
		ConcreteShellCommand(shellRunner: self, label: label, text, environment: env)
	}

	public func sh(label: String? = nil, _ text: String, env: [String: String]? = nil) throws {
		try self.cmd(label: label, text, env: env)
			.execute()
	}

	public func cmd<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil) -> ConcreteShellQuery<T> {
		ConcreteShellQuery<T>(shellRunner: self, label: label, text, environment: env)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil) throws -> T {
		try self.cmd(label: label, text, as: type, env: env)
			.execute()
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, env: [String: String]? = nil) throws -> T {
		try self.cmd(label: label, text, as: T.self, env: env)
			.execute()
	}

	public func cmd(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) -> ConcreteBooleanShellQuery {
		ConcreteBooleanShellQuery(shellRunner: self, label: label, text, interpretation, environment: env)
	}

	public func sh(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) throws -> Bool {
		try self.cmd(label: label, text, interpretation, env: env).execute()
	}
}
