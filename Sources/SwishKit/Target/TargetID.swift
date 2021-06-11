import Foundation
import Logging

public protocol TargetID {
	var name: String { get }
	var target: Target { get }

	var dependsOn: [Self] { get }
	func resolve(force: Bool) throws
}

public extension TargetID {

	func resolve(force: Bool) throws {

		SwishLogger.info("Resolving: \(self), depends on: \(self.dependsOn)")

		for dependentTargetId in self.dependsOn {
			try dependentTargetId.resolve(force: force)
		}

		let target = self.target
		if target.isNeeded || force {
			try target.execute()
		} else {
			SwishLogger.info("Skipping \(self), not needed")
		}
	}
}

public extension TargetID where Self: RawRepresentable, RawValue == String {

	var name: String {
		String(describing: Self.self) + rawValue
	}
}
