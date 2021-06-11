public protocol Command {
	func execute() throws  
}

public extension Command {
	func callAsFunction() throws {
		try execute()
	}
}
