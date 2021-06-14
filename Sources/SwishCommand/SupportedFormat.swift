import Foundation
import MPath
import SwishDescription
import Yams

enum SupportedFormat: String {
	case json
	case yaml, yml
	// case swift <-- not yet supported :(

	func load(path: Path) throws -> Swish {
		let data: Data = try path.read()
		switch self {
		case .json:
			return try JSONDecoder().decode(SwishDescription.Swish.self, from: data)
		case .yml, .yaml:
			return try YAMLDecoder().decode(SwishDescription.Swish.self, from: data)
		}
	}
}
