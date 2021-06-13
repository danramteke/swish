import Foundation

extension SwishContext {

	public func cmd(label: String? = nil, _ text: String, env: [String: String]? = nil) -> ShellCommand {
		self.shellRunner.cmd(label: label, text, env: env)
	}

	public func sh(label: String? = nil, _ text: String, env: [String: String]? = nil) throws {
		try self.shellRunner.sh(label: label, text, env: env)
	}

	public func cmd<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil) -> ConcreteShellQuery<T> {
		self.shellRunner.cmd(label: label, text, as: type, env: env)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil) throws -> T {
		try self.shellRunner.sh(label: label, text, as: type, env: env)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, env: [String: String]? = nil) throws -> T {
		try self.shellRunner.sh(label: label, text, env: env)
	}

	public func cmd(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) -> ConcreteBooleanShellQuery {
		self.shellRunner.cmd(label: label, text, interpretation, env: env)
	}

	public func sh(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) throws -> Bool {
		try self.shellRunner.sh(label: label, text, interpretation, env: env)
	}
}
