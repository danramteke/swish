public protocol Query {
	associatedtype Output
	func execute() throws -> Output
}

public extension Query {
    func callAsFunction() throws -> Output {
        try execute()
    }
}
