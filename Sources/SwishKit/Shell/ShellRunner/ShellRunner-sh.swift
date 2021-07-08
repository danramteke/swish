import Foundation
import MPath

extension ShellRunner {
    public func cmd(label: String? = nil, _ text: String, env: [String: String]? = nil, options: ShellOptions = .default) -> ShellCommand {
		ConcreteShellCommand(shellRunner: self, label: label, text, environment: env, options: options)
	}

	public func sh(label: String? = nil, _ text: String, env: [String: String]? = nil, options: ShellOptions = .default) throws {
        try self.cmd(label: label, text, env: env, options: options)
			.execute()
	}

	public func cmd<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil, options: ShellOptions = .default) -> ConcreteShellQuery<T> {
        ConcreteShellQuery<T>(shellRunner: self, label: label, text, environment: env, options: options)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, env: [String: String]? = nil, options: ShellOptions = .default) throws -> T {
        try self.cmd(label: label, text, as: type, env: env, options: options)
			.execute()
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, env: [String: String]? = nil, options: ShellOptions = .default) throws -> T {
        try self.cmd(label: label, text, as: T.self, env: env, options: options)
			.execute()
	}

	public func cmd(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil, options: ShellOptions = .default) -> ConcreteBooleanShellQuery {
        ConcreteBooleanShellQuery(shellRunner: self, label: label, text, interpretation, environment: env, options: options)
	}

	public func sh(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil, options: ShellOptions = .default) throws -> Bool {
		try self.cmd(label: label, text, interpretation, env: env).execute()
	}
}
