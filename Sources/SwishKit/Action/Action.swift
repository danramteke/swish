import Foundation

public protocol Action {
	var dependsOn: [ActionID] { get }

	var isNeeded: Bool { get }

	func execute() throws
}

public extension Action {
	var dependsOn: [ActionID] { [] }
	var isNeeded: Bool { true }
}
