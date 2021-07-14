extension Scaffold {
  static let swishDescription = """
import Foundation

public struct Swish: Codable {
    public let scripts: [String: Script]
    public init(scripts: [String: ScriptConvertible]) {
        self.scripts = scripts.mapValues { $0.asScript }
    }
}

public enum Script: Codable, Equatable {
    case swift(Swift)
    case text(String)

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let string):
            var container = encoder.singleValueContainer()
            try container.encode(string)
        case .swift(let swift):
            try swift.encode(to: encoder)
        }
    }

    public init(from decoder: Decoder) throws {
        do {
            let swift = try Swift(from: decoder)
            self = .swift(swift)
        } catch {
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            self = .text(string)
        }
    }
}

public struct Swift: Codable, Equatable {
    public let path: String
    public let target: String
    public let arguments: String?
    public init(path: String = ".", target: String, arguments: String? = nil) {
        self.path = path
        self.target = target
        self.arguments = arguments
    }
}

public protocol ScriptConvertible {
    var asScript: Script { get }
}

extension Swift: ScriptConvertible {
    public var asScript: Script {
        .swift(self)
    }
}

extension String: ScriptConvertible {
    public var asScript: Script {
        .text(self)
    }
}

"""
}
