import Foundation
extension Docker {
  public struct PS: ShellAction {
    public func render() -> [String] {
      ["docker", "ps", "--format", "'{{json .}}'", "--no-trunc"]
    }

    public let name = "Docker.ps"
  }
}
