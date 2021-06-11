/// Some commands may not be required to run everytime. For example, downlading a large file, rendering a large image, or install a package.
/// If your `Command` conforms to `RequirableCommand`

/// - Returns whether or not the command has determined it must run, or if it can safely be skipped.
public protocol RequirableCommand: Command {
	var isRequired: Bool { get }
}


/// RequirableCommands default to yes, they must run
public extension RequirableCommand {
	var isRequired: Bool { true }
}
