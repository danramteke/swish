import Version
extension Agvtool {
  public struct WhatMarketingVersion: ShellQuery {
    public let id = ID()
    public typealias ResultSuccessType = Version

    public let name = "Avgtool.WhatVersion"
    public init() { }

    public func render() -> [String] {
      return ["xcrun", "agvtool", "what-marketing-version", "-terse1"]
    }
  }
}

extension Version: ShellOutputInitable {
  public init(shellQueryOutput output: String) throws {
    let trimmedOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
    guard let version = Version(trimmedOutput) else {
      throw RunError.parseError
    }

    self = version
  }
}
