import Foundation

public protocol Query {
	associatedtype Output
	func execute() throws -> Output
}
