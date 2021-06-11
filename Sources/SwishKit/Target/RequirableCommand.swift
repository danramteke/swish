public protocol RequirableCommand: Command {
	var isRequired: Bool { get }
}

public extension RequirableCommand {
	var isRequired: Bool { true }
}
