import Foundation

public protocol Action {
	var dependsOn: [ActionID] { get }

	var isNeeded: Bool { get }

	func execute() throws

	func resolve(force: Bool) throws
}

public extension Action {
	var dependsOn: [ActionID] { [] }
	var isNeeded: Bool { true }
	func resolve(force: Bool) throws {
		try self.dependsOn.forEach {
			try $0.action.resolve(force: force)
		}

		if self.isNeeded || force {
			try self.execute()
		} else {
			//print("Skipping \(self.id), not needed".red)
		}
	}
}
