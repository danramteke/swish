import Foundation
public struct Path: Codable {
  public let path: String
  public init(_ path: String) {
    self.path = path
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
}

