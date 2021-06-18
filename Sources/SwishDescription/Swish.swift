import Foundation
/// import SwishDescription
///
/// let swish = Swish(
///   scripts: [
///     .script("clean", "rm -fr .build; rm -fr tmp"),
///     .script("build", "swift build"),
///     .script("test", "swift test"),
///     .script("clean", "rm -fr"),
///     .script("icons", "swift run icons"),
///   ]
/// )


/// import SwishDescription
///
/// let swish = Swish(
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

public struct Swish: Codable {
	public let scripts: [String: Script]
	public init(scripts: [String: Script]) {
		self.scripts = scripts
	}
}

//public enum Swishable: Codable {
//	case script(Script)
//	case swishKit(path: String, target: String)
//
//	init(string: String) {
//		self = .script(Script(stringLiteral: string))
//	}
//
//	public init(from decoder: Decoder) throws {
//		let container = try decoder.singleValueContainer()
//		let string = try container.decode(String.self)
//
//		self = .script(Script(stringLiteral: string))
//	}
//}

public struct SwishKitTarget: Codable, Equatable {
	public let path: String
	public let target: String
}

public enum Script: Codable, ExpressibleByStringLiteral, Equatable {
	case swishKit(SwishKitTarget)
	case text(String)



	public func encode(to encoder: Encoder) throws {
		switch self {
		case .text(let string):
			var container = encoder.singleValueContainer()
			try container.encode(string)
		case .swishKit(let swishKitTarget):
			try swishKitTarget.encode(to: encoder)
		}
	}

	public init(from decoder: Decoder) throws {
		do {
			let swishKitTarget = try SwishKitTarget(from: decoder)
			self = .swishKit(swishKitTarget)
		} catch {
			let container = try decoder.singleValueContainer()
			let string = try container.decode(String.self)

			self = .text(string)
		}
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
