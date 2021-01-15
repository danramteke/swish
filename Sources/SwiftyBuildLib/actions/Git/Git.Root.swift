extension Git {
  public struct Root: ShellQuery {
    public init() { }
    public typealias ResultSuccessType = Path
    public let name: String = "Git.Root"
    public func render() -> [String] { 
      ["git", "rev-parse", "--show-toplevel"] 
    }
  }
}
