public let SharedShellHelper = ShellHelper()

public func sh(_ text: String) -> ShellCommand {
	ConcreteShellCommand(text, shellRunner: SharedShellHelper)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type) -> ConcreteShellQuery<T> {
	ConcreteShellQuery<T>(text, shellRunner: SharedShellHelper)
}

public func sh(_ text: String, _ interpretation: BooleanStringInterpretation) -> ConcreteBooleanShellQuery {
	ConcreteBooleanShellQuery(text, interpretation: interpretation, shellRunner: SharedShellHelper)
}

