import Foundation
import Logging

public protocol TargetID {
	var name: String { get }
	var target: Target { get }

	var dependsOn: [Self] { get }
}


public extension TargetID where Self: RawRepresentable, RawValue == String {

	var name: String {
		String(describing: Self.self) + rawValue
	}
}
