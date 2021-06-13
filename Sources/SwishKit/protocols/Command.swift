public protocol Command {
	func execute() throws  
	var label: String? { get }
}

public extension Command {
	func callAsFunction() throws {
		try execute()
	}

	var label: String? { 
		nil 
	} 
}
