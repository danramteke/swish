import Foundation

public protocol TargetID {
	var target: Target { get }
	var name: String { get }

	func resolve(force: Bool) throws
}

public extension TargetID {

	func resolve(force: Bool) throws {
		let target = self.target
		try target.dependsOn.forEach {
			try $0.resolve(force: force)
		}

		if target.isNeeded || force {
			try target.execute()
		} else {
			//print("Skipping \(self.id), not needed".red)
		}
	}
}

public extension TargetID where Self: RawRepresentable, RawValue == String {

	var name: String {
		String(describing: Self.self) + rawValue
	}
}
