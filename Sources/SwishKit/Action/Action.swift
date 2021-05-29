import Foundation

public protocol Action: Command {
	var dependsOn: [ActionID] { get }
	var isNeeded: Bool { get }
}

public extension Action {

	var dependsOn: [ActionID] { [] }
	var isNeeded: Bool { true }
}
