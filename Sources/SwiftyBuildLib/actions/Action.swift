import Foundation

public protocol Action: Codable {
  func render() -> String
}

public extension Action {
  func dryRun() throws {
    print(self.render())
  }
}