
extension Agvtool {
  public struct WhatVersion: ShellQuery {
    public typealias ResultSuccessType = Int

    public let name = "Avgtool.WhatVersion"
    public init() { }

    public func render() -> [String] {
      return ["xcrun", "agvtool", "what-version", "-terse"]
    }
  }
}
