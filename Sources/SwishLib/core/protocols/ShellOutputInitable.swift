import Foundation

public protocol ShellOutputInitable {
  init(shellQueryOutput output: String) throws
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

extension String: ShellOutputInitable {
  public init(shellQueryOutput: String) throws {
    self = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

extension Int: ShellOutputInitable {
  public init(shellQueryOutput: String) throws {
    let trimmedOutput = shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines)
    guard let value = Int(trimmedOutput) else {
      throw RunError.parseError
    }

    self = value
  }
}

extension Path: ShellOutputInitable {
  public init(shellQueryOutput: String) throws {
    self.init(shellQueryOutput.trimmingCharacters(in: .whitespacesAndNewlines))
  }
}
