import Foundation

extension Array: StdOutputInitable, ShellOutputInitable where Element: StdOutputInitable & ShellOutputInitable {

  public init(stdOutput: String) throws {
    self = try stdOutput.split(separator: "\n").map { String($0) }.map { try Element(stdOutput: $0) }
  }
}
