import Foundation

public class Echo: ShellAction {
  public let id = UUID()
  public let name: String = "Echo"
  public let string: String
  public init(_ string: String) { self.string = string }

  public func render() -> [String] {
    ["echo", string]
  }
}
