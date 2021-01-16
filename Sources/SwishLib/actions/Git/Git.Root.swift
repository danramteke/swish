import Combine

extension Git {
  public struct Root: ShellQuery {
    public let id = ID()

    public init() { }
    public typealias ResultSuccessType = Path
    public let name: String = "Git.Root"
    public func render() -> [String] { 
      ["git", "rev-parse", "--show-toplevel"] 
    }

    public var publisher: CurrentValueSubject<ResultSuccessType, Never> = .init("initialValue")

  }
}
