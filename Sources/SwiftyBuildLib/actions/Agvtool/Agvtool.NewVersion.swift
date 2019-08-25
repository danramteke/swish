extension Agvtool {
  public struct NewVersion: ShellAction {
    public let name = "Avgtool.NewVersion"
    public let number: Int
    public let all: Bool
    public init(number: Int, all: Bool = true) {
      self.number = number
      self.all = all
    }

    public func render() -> [String] {
      var buffer = ["xcrun", "agvtool", "new-version", String(number)]
      if all {
        buffer.append("-all")
      }
      return buffer
    }
  }
}