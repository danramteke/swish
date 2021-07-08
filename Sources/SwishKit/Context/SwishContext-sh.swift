import Foundation

extension SwishContext {

	public func cmd(label: String? = nil, _ text: String, env: [String: String]? = nil, options: ShellOptions = .default) -> ShellCommand {
        self.shellRunner.cmd(label: label, text, env: env, options: options)
	}

    public func sh(label: String? = nil, _ text: String, env: [String: String]? = nil, options: ShellOptions = .default) throws {
        try self.shellRunner.sh(label: label, text, env: env, options: options)
	}

	public func cmd<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil, options: ShellOptions = .default) -> ConcreteShellQuery<T> {
		self.shellRunner.cmd(label: label, text, as: type, env: env, options: options)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil, options: ShellOptions = .default) throws -> T {
		try self.shellRunner.sh(label: label, text, as: type, env: env, options: options)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, env: [String: String]? = nil, options: ShellOptions = .default) throws -> T {
		try self.shellRunner.sh(label: label, text, env: env, options: options)
	}

	public func cmd(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil, options: ShellOptions = .default) -> ConcreteBooleanShellQuery {
		self.shellRunner.cmd(label: label, text, interpretation, env: env, options: options)
	}

	public func sh(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil, options: ShellOptions = .default) throws -> Bool {
        try self.shellRunner.sh(label: label, text, interpretation, env: env, options: options)
	}
}
