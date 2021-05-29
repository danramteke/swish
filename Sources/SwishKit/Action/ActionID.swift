import Foundation

public protocol ActionID {
	var action: Action { get }
	var name: String { get }
}

public extension ActionID where Self: RawRepresentable, RawValue == String {
    var name: String {
        rawValue
    }
}
