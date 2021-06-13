import Foundation

public protocol Target: Identifiable {
	/// ID of the target. Swish uses the id to track if a target has run already.
	var id: String { get }

	/// The command to run to achieve this target.
	/// Can be null, for example, if a `Command` is a "meta-command", 
	/// only declaring dependencies.
	/// Or if you determine that nothing needs to be run. For example, a command that
	/// installs packages from a package manager could check if the package is installed
	/// already, and if so, return nil.
	///
	/// - Returns the `Command` to run for this `Target`. Or `nil`, if there is nothing to run
	var command: Command? { get }

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
