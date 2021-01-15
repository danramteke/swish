import Foundation

public struct Path: Codable, Equatable, Comparable {

  public let path: String
  public init(_ path: String) {
    self.path = path
  }
  public static let separator: String = "/"
  public var components: [String] {
    path.split(separator: Character(Self.separator)).map(String.init)
  }
    
  public var quoted: String {
    if !path.starts(with: "\"") && !path.hasSuffix("\"") && !path.contains("\"") {
      return "\"\(self.path)\""
    } else {
      return self.path
    }
  }

  public var url: URL {
    return URL(fileURLWithPath: path)
  }

  public static var current: Path {
    get {
      .init(FileManager.default.currentDirectoryPath)
    }
  }

  public static func < (lhs: Path, rhs: Path) -> Bool {
    lhs.path < rhs.path
  }
}

