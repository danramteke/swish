import Foundation

public protocol Action: Codable {
  var name: String { get }
  func run(in: Context) throws
}

public protocol SwiftAction: Action {
  func run() -> (success: Bool, stdout: String, stderr: String)
}

public protocol ShellAction: Action {
  func render() -> [String]
}

public enum ActionType {
  case swift(SwiftAction)
  case shell(ShellAction)
}