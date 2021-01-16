
/**
 * Sometimes you need to run something against the shell
 */
public struct Shell: ShellAction  {
  public let id = ID()
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
