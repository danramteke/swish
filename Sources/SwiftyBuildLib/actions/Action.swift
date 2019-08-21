import Foundation

public protocol Action: Codable {
  func render() -> [String]
  var name: String { get }
}
