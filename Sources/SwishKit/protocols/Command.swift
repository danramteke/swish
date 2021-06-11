public protocol Command {
	func execute() throws  
}

public extension Command {
	func callAsFunction() throws {
		try execute()
	}
}

public protocol RequirableCommand: Command {
	var isRequired: Bool { get }
}

public extension RequirableCommand {
	var isRequired: Bool { true }
}
