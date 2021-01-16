import Foundation

public protocol Action {
  var name: String { get }
  func run(in: Context) throws

  var id: ID { get }
  typealias ID = UUID
}

extension Action {
  public func run() throws {
    try run(in: Context.default)
  }
}


public protocol ShellAction: Action {
  func render() -> [String]
}

public protocol ShellQuery: ShellAction {

  associatedtype ResultSuccessType
  func parseResult(output: String?, error: String?) -> Result<ResultSuccessType, Error>
}

public protocol ShellQueryOutputInitable {
  init(shellQueryOutput output: String) throws
}

public extension ShellQuery where ResultSuccessType: ShellQueryOutputInitable {
  func parseResult(output: String?, error: String?) -> Result<ResultSuccessType, Error> {


    return Result {
      guard let output = output else {
        throw RunError.queryHadNoOutput
      }
      let trimmedOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
      return try ResultSuccessType.init(shellQueryOutput: trimmedOutput)
    }
  }
}

extension RawRepresentable where RawValue == String {
  public init(shellQueryOutput: String) throws {
    let trimmedOutput = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Self.init(rawValue: trimmedOutput) else {
      throw RunError.parseError
    }

    self = value
  }
}

extension String: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    self = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

extension Int: ShellQueryOutputInitable {
  public init(shellQueryOutput: String) throws {
    let trimmedOutput = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(trimmedOutput) else {
      throw RunError.parseError
    }

    self = value
  }
}

extension Path: ShellQueryOutputInitable {
    public init(shellQueryOutput: String) throws {
        self.init(shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines))
    }
}
