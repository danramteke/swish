import Foundation

public protocol Action {
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

public protocol ShellQueryOutputInitable {
  init(shellQueryOutput output: String) throws
}

public extension ShellQuery where ResultSuccessType: ShellQueryOutputInitable {
  func parseResult(output: String, error: String?) -> Result<ResultSuccessType, Error> {
    let trimmedOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
    return Result {
      try ResultSuccessType.init(shellQueryOutput: trimmedOutput)
    }
  }
}

extension String: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    self = shellQueryOutput
  }
}

extension Int: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    guard let value = Int(shellQueryOutput) else {
      throw RunError.parseError
    }

    self = value
  }
}
