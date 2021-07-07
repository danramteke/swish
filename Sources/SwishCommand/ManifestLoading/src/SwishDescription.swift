
import Foundation

public struct Swish: Codable {
    public let scripts: [String: Script]
    public init(scripts: [String: ScriptConvertible]) {
        self.scripts = scripts.mapValues { $0.asScript }
    }
}

public enum Script: Codable, Equatable {
    case swiftTarget(SwiftTarget)
    case text(String)

    public static func swift(path: String, target: String) -> Script {
        .swiftTarget(SwiftTarget(path: path, target: target))
    }

    public static func swift(path: String, target: String, arguments: String) -> Script {
        .swiftTarget(SwiftTarget(path: path, target: target, arguments: arguments))
    }

    public func encode(to encoder: Encoder) throws {
        switch self {
        case .text(let string):
            var container = encoder.singleValueContainer()
            try container.encode(string)
        case .swiftTarget(let swiftTarget):
            try swiftTarget.encode(to: encoder)
        }
    }

    public init(from decoder: Decoder) throws {
        do {
            let swiftTarget = try SwiftTarget(from: decoder)
            self = .swiftTarget(swiftTarget)
        } catch {
            let container = try decoder.singleValueContainer()
            let string = try container.decode(String.self)

            self = .text(string)
        }
    }
}

public struct SwiftTarget: Codable, Equatable {
    public let path: String
    public let target: String
    public let arguments: String?
    public init(path: String, target: String, arguments: String? = nil) {
        self.path = path
        self.target = target
        self.arguments = arguments
    }
}

public protocol ScriptConvertible {
    var asScript: Script { get }
}

extension SwiftTarget: ScriptConvertible {
    public var asScript: Script {
        .swiftTarget(self)
    }
}

extension String: ScriptConvertible {
    public var asScript: Script {
        .text(self)
    }
}
