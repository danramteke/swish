import Foundation
import MPath
import SwishDescription
import Yams

enum ManifestFormat: CaseIterable {
	case json
	case yaml
    case swift

    init?(rawValue: String) {
        switch rawValue {
        case "json":
            self = .json
        case "yaml", "yml":
            self = .yaml
        case "swift":
            self = .swift
        default:
            return nil
        }
    }

	func load(at manifestPath: Path) throws -> Swish {

		switch self {
		case .json:
            let d = JSONDecoder()
            let data: Data = try manifestPath.read()
			return try d.decode(Swish.self, from: data)
            
		case .yaml:
            let d = YAMLDecoder()
            let data: Data = try manifestPath.read()
			return try d.decode(Swish.self, from: data)

        case .swift:
            return try SwiftManifestLoader().load(at: manifestPath)
		}
	}

    static func detect(at manifestPath: Path) throws -> Swish {
        if let ext = manifestPath.extension,
           let format = ManifestFormat(rawValue: ext) {

            return try format.load(at: manifestPath)
        } else {

            for format in ManifestFormat.allCases {
                do {
                    return try format.load(at: manifestPath)
                } catch {

                }
            }

            throw ManifestFormatError()
        }
    }
}
