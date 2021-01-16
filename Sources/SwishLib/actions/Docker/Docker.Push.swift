import Foundation

extension Docker {
  public struct Push: ShellAction {
    public let name = "Docker.Push"
    public let id = UUID()

    public let tag: String
    public init(tag: String) {
      self.tag = tag
    }
    public func render() -> [String] {
      ["docker", "push", tag]
    }
  }
}
