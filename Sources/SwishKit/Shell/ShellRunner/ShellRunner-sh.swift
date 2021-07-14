import Foundation
import MPath

extension ShellRunner {
	public func cmd(label: String? = nil, _ text: String, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) -> ShellCommand {
		ConcreteShellCommand(shellRunner: self, label: label, text, workingDirectory: directory, environment: env, options: options)
	}

	public func sh(label: String? = nil, _ text: String, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) throws {
        try self.cmd(label: label, text, in: directory, env: env, options: options)
			.execute()
	}

	public func cmd<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) -> ConcreteShellQuery<T> {
        ConcreteShellQuery<T>(shellRunner: self, label: label, text, workingDirectory: directory, environment: env, options: options)
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, as type: T.Type, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) throws -> T {
        try self.cmd(label: label, text, as: type, in: directory, env: env, options: options)
			.execute()
	}

	public func sh<T: ShellOutputInitable>(label: String? = nil, _ text: String, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) throws -> T {
        try self.cmd(label: label, text, as: T.self, in: directory, env: env, options: options)
			.execute()
	}

	public func cmd(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) -> ConcreteBooleanShellQuery {
        ConcreteBooleanShellQuery(shellRunner: self, label: label, text, interpretation, workingDirectory: directory, environment: env, options: options)
	}

	public func sh(label: String? = nil, _ text: String, _ interpretation: BooleanStringInterpretation, in directory: Path? = nil, env: [String: String]? = nil, options: ShellOptions = .default) throws -> Bool {
		try self.cmd(label: label, text, interpretation, in: directory, env: env).execute()
	}
}
