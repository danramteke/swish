import Foundation
import Logging

public protocol Target: Identifiable {
	/// ID of the target. Swish uses the id to track if a target has run already.
	var id: String { get }

	/// The command to run to achieve this target
	var command: RequirableCommand { get }

	/// - Returns the targets that must run before this `Target` can safely run
	var dependsOn: [Self] { get }
}

public extension Target where Self: RawRepresentable, RawValue == String {

	/// default ``Identifiable`` conformance for `enum`s.
	///
	/// - Returns the name of the `enum` follwed by a `.` and the `rawValue` of the enum.
	var id: String {
		String(describing: Self.self) + "." + rawValue
	}
}
