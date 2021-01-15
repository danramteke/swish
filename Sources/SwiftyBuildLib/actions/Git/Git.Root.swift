extension Git {
  public struct Root: ShellQuery {
    public typealias ResultSuccessType=String
    public let name: String = "Git.Root"
    public func render() -> [String] { 
      ["git", "rev-parse", "--show-toplevel"] 
    }
  }
}
