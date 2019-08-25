
extension Agvtool {
  public struct WhatVersion: ShellQuery {
    public let name = "Avgtool.WhatVersion"
    public init() { }

    public func render() -> [String] {
      return ["xcrun", "agvtool", "what-version", "-terse"]
    }

    public func parseResult(output: String, error: String?) -> Result<Int, Error> {
      if let int = Int(output.trimmingCharacters(in: .whitespacesAndNewlines)) {
        return .success(int)
      } else {
        return .failure(RunError.parseError)
      }
    }
  }
}
