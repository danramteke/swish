import Foundation
extension Docker {
  public struct PS: ShellAction {
    public let id = UUID()
    public func render() -> [String] {
      ["docker", "ps", "--format", "'{{json .}}'", "--no-trunc"]
    }

    public let name = "Docker.ps"
  }
}
