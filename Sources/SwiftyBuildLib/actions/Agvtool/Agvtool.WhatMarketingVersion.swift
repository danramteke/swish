import Version
extension Agvtool {
  public struct WhatMarketingVersion: ShellQuery {
    public let name = "Avgtool.WhatVersion"
    public init() { }

    public func render() -> [String] {
      return ["xcrun", "agvtool", "what-marketing-version", "-terse1"]
    }

    public func parseResult(output: String, error: String?) -> Result<Version, Error> {
      let trimmedOutput = output.trimmingCharacters(in: .whitespacesAndNewlines)
      print(trimmedOutput)
      guard let version = Version(trimmedOutput) else {

        return .failure(RunError.parseError)
      }

      return .success(version)
    }
  }
}
