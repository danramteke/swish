
/**
 * Sometimes you need to run something against the shell
 */
public struct Shell: ShellAction  {
  public let tokens: [String]

  public init(_ tokens: [String]) {
    self.tokens = tokens
  }

  public init(tokens: [String]) {
    self.tokens = tokens
  }

  public let name: String = "Shell"

  public func render() -> [String] {
    return tokens
  }
}

public extension Context {
  func shell(_ tokens: [String]) throws {
    let action = Shell(tokens: tokens)
    try self.run(action: action)
  }
}
