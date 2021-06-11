import Foundation
import Logging

public protocol Target: Identifiable {
	var id: String { get }
	var command: RequirableCommand { get }

	var dependsOn: [Self] { get }
}

public extension Target where Self: RawRepresentable, RawValue == String {

	var id: String {
		String(describing: Self.self) + "." + rawValue
	}
}
