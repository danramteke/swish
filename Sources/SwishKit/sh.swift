public let SharedShellHelper = ShellHelper()

public func sh(_ text: String) -> ShellCommand {
	ConcreteShellCommand(text)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type) -> ConcreteShellQuery<T> {
	ConcreteShellQuery<T>(text)
}

public func sh(_ text: String, _ interpretation: BooleanShellQuery.Interpretation) -> BooleanShellQuery {
	BooleanShellQuery(text, interpretation: interpretation)
}

public func sh(_ text: String, dependsOn commands: [Command]) -> DependentShellCommand {
	DependentShellCommand(text, dependsOn: commands)
}

public func sh(_ text: String, dependsOn command: Command) -> DependentShellCommand {
	DependentShellCommand(text, dependsOn: [command])
}
