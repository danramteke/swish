import Foundation
import MPath
import SwishDescription
import Yams

enum SupportedFormat: String {
	case json
	case yaml, yml
    case swift

	func load(path: Path) throws -> Swish {

		switch self {
		case .json:
            let d = JSONDecoder()
            let data: Data = try path.read()
			return try d.decode(Swish.self, from: data)
            
		case .yml, .yaml:
            let d = YAMLDecoder()
            let data: Data = try path.read()
			return try d.decode(Swish.self, from: data)

        case .swift:
            return try SwiftManifestLoader().load(at: path)
		}
	}
}
