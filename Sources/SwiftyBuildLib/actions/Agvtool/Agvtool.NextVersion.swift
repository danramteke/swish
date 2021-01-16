extension Agvtool {
  public struct NextVersion: ShellAction {
    public let id = ID()
    public let name = "Avgtool.NextVersion"
    public let all: Bool
    public init(all: Bool = true) {
      self.all = all
    }

    public func render() -> [String] {
      var buffer = ["xcrun", "agvtool", "next-version"]
      if all {
        buffer.append("-all")
      }
      return buffer
    }
  }
}
