public let SharedShellRunner = ShellRunner()

public func sh(_ text: String) -> ShellCommand {
	ConcreteShellCommand(text, shellRunner: SharedShellRunner)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type) -> ConcreteShellQuery<T> {
	ConcreteShellQuery<T>(text, shellRunner: SharedShellRunner)
}

public func sh(_ text: String, _ interpretation: BooleanStringInterpretation) -> ConcreteBooleanShellQuery {
	ConcreteBooleanShellQuery(text, interpretation: interpretation, shellRunner: SharedShellRunner)
}
