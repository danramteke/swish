import Foundation

public protocol Action: Codable {
  func render() -> [String]
}
