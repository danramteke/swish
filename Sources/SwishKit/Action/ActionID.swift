import Foundation

public protocol ActionID {
	var action: Action { get }
	var name: String { get }

	func resolve(force: Bool) throws
}

public extension ActionID {

	func resolve(force: Bool) throws {
		let action = self.action
		try action.dependsOn.forEach {
			try $0.resolve(force: force)
		}

		if action.isNeeded || force {
			try action.execute()
		} else {
			//print("Skipping \(self.id), not needed".red)
		}
	}
}

public extension ActionID where Self: RawRepresentable, RawValue == String {

	var name: String {
		String(describing: Self.self) + rawValue
	}
}
