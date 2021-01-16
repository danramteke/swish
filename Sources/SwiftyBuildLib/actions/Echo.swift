import Foundation

public struct Echo: ShellAction {
  public let name: String = "Echo"
  public let string: String
  public init(_ string: String) { self.string = string }

  public func render() -> [String] {
    ["echo" + string]
  }
}
