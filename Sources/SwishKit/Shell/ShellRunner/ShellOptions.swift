import Foundation

public typealias ShellOptions = Set<ShellOption>
public enum ShellOption: String, Option {

    case console

    public static func < (lhs: Self, rhs: Self) -> Bool { lhs.order < rhs.order }

    private var order: Int {
        switch self {
        case .console: return 1
        }
    }
}

public extension Set where Element == ShellOption {
    static let `default`: Self = [.console]
}

public protocol Option: RawRepresentable, Hashable, CaseIterable, Comparable {}
public extension Set where Element: Option & StringProtocol, Element.RawValue == String {
	var rawValue: String {
		Array(self).sorted().joined(separator: ",")
	}

	init?(rawValue: String) {
		let values: [Element] = rawValue
			.split(separator: ",")
			.map { String($0) }
			.compactMap { Element.init(rawValue: $0) }
		self = Set(values)
	}
}
