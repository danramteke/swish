import Foundation
/// import ScriptDescription
///
/// let scripts = Scripts(
///   scripts: [
///     .script("clean", "rm -fr .build; rm -fr tmp"),
///     .script("build", "swift build"),
///     .script("test", "swift test"),
///     .script("clean", "rm -fr"),
///     .script("icons", "swift run icons"),
///   ]
/// )


/// import ScriptDescription
///
/// let scripts = Scripts(
///   scripts: [
///     "clean": "rm -fr .build; rm -fr tmp",
///     "build": "swift build",
///     "test": "swift test",
///     "clean", "rm -fr",
///     "icons", "swift run icons",
///     "stew", "swift run --package-path swift-scripts stew"
///     "stew", .swift(path: "swift-scripts", target: "stew")
///     "local", .swift("local")
///   ]
/// )


/*json
{
	"scripts": {
		"build": "swift build",
		"stew": {
			"path": "swift-scripts",
			"target: "stew",
		}
	}
}
*/

public struct Scripts: Codable {
	public let scripts: [String: Script]
	public init(scripts: [String: Script]) {
		self.scripts = scripts
	}
}

public enum Script: Codable, ExpressibleByStringLiteral, Equatable {

	case text(String)

	public func encode(to encoder: Encoder) throws {
		switch self {
		case .text(let string):
			var container = encoder.singleValueContainer()
			try container.encode(string)
		}
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let string = try container.decode(String.self)

		self = .text(string)
	}
	

	public init(extendedGraphemeClusterLiteral value: Self.StringLiteralType) {
		self = .text(value)
	}

	public init(stringLiteral value: Self.StringLiteralType) {
		self = .text(value)
	}

	public typealias StringLiteralType = String
	public typealias ExtendedGraphemeClusterLiteralType = String
}
