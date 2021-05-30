import MPath

public let SharedShellRunner = ShellRunner()

public func cmd(_ text: String) -> ShellCommand {
	ConcreteShellCommand(text, shellRunner: SharedShellRunner)
}

public func sh(_ text: String) throws {
	try cmd(text).execute()
}

public func cmd<T: ShellOutputInitable>(_ text: String, as type: T.Type) -> ConcreteShellQuery<T> {
	ConcreteShellQuery<T>(text, shellRunner: SharedShellRunner)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type) throws -> T {
	try cmd(text, as: type).execute()
}

public func sh<T: ShellOutputInitable>(_ text: String) throws -> T {
	try cmd(text, as: T.self).execute()
}

public func cmd(_ text: String, _ interpretation: BooleanStringInterpretation) -> ConcreteBooleanShellQuery {
	ConcreteBooleanShellQuery(text, interpretation, shellRunner: SharedShellRunner)
}

public func sh(_ text: String, _ interpretation: BooleanStringInterpretation) throws -> Bool {
	try cmd(text, interpretation).execute()
}
