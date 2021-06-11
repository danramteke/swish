import Foundation

public protocol Target: Command {
	var isNeeded: Bool { get }
}

public extension Target {
	var isNeeded: Bool { true }
}
