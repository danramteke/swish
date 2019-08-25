import Foundation

public protocol Action: Codable {
  var name: String { get }
}

public protocol ShellAction: Action {
  func render() -> [String]
}

public protocol ShellQuery: Action {
  func render() -> [String]

  associatedtype ResultSuccessType
  func parseResult(output: String, error: String?) -> Result<ResultSuccessType, Error>
}
