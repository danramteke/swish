
/**
 * Sometimes you need to run something against the shell
 */
public struct Shell: ShellAction  {
  public let tokens: [String]

  public init(_ tokens: [String]) {
    self.tokens = tokens
  }

  public var name: String { return "Shell" }
  public func render() -> [String] {
    return tokens
  }
}


