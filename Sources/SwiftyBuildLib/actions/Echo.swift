import Foundation

public struct Echo {
  public let string: String
  public init(string: String) { }

  public func render() -> [String] {
    ["echo" + string]
  }
}
