import MPath

public let SharedShellRunner = ShellRunner()

public func cmd(_ text: String, env: [String: String]? = nil) -> ShellCommand {
	ConcreteShellCommand(text, environment: env, shellRunner: SharedShellRunner)
}

public func sh(_ text: String, env: [String: String]? = nil) throws {
	try cmd(text, env: env).execute()
}

public func cmd<T: ShellOutputInitable>(_ text: String, as type: T.Type, env: [String: String]? = nil) -> ConcreteShellQuery<T> {
	ConcreteShellQuery<T>(text, environment: env, shellRunner: SharedShellRunner)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type, env: [String: String]? = nil) throws -> T {
	try cmd(text, as: type, env: env).execute()
}

public func sh<T: ShellOutputInitable>(_ text: String, env: [String: String]? = nil) throws -> T {
	try cmd(text, as: T.self, env: env).execute()
}

public func cmd(_ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) -> ConcreteBooleanShellQuery {
	ConcreteBooleanShellQuery(text, interpretation, environment: env, shellRunner: SharedShellRunner)
}

public func sh(_ text: String, _ interpretation: BooleanStringInterpretation, env: [String: String]? = nil) throws -> Bool {
	try cmd(text, interpretation, env: env).execute()
}
