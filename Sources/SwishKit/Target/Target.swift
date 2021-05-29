import Foundation

public protocol Target: Command {
	var dependsOn: [TargetID] { get }
	var isNeeded: Bool { get }
}

public extension Target {

	var dependsOn: [TargetID] { [] }
	var isNeeded: Bool { true }
}
