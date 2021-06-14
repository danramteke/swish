import Foundation
import MPath
import ScriptsDescription
import Yams

enum SupportedFormat: String {
	case json
	case yaml, yml
	// case swift <-- not yet supported :(

	func load(path: Path) throws -> Scripts {
		let data: Data = try path.read()
		switch self {
		case .json:
			return try JSONDecoder().decode(ScriptsDescription.Scripts.self, from: data)
		case .yml, .yaml:
			return try YAMLDecoder().decode(ScriptsDescription.Scripts.self, from: data)
		}
	}
}
