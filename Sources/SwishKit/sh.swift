public let sharedShellHelper = ShellHelper()

public func sh(_ text: String) -> ShellCommand {
	ShellCommand(text)
}

public func sh<T: ShellOutputInitable>(_ text: String, as type: T.Type) -> ShellQuery<T> {
	ShellQuery<T>(text)
}

//public func shq<T: ShellOutputInitable>(_ text: String, as type: T.Type) -> Result<T, Error> {
//	ShellQuery<T>(text).execute()
//}

public func sh(_ text: String, dependsOn commands: [Command]) -> DependentShellCommand {
	DependentShellCommand(text, dependsOn: commands)
}

public func sh(_ text: String, dependsOn command: Command) -> DependentShellCommand {
	DependentShellCommand(text, dependsOn: [command])
}
