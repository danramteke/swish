extension Agvtool {
  public struct NewMarketingVersion: ShellAction {
    public let name = "Avgtool.NewMarketingVersion"
    public let string: String 
    public init(_ string: String) {
      self.string = string
    }

    public func render() -> [String] {
      return ["xcrun", "agvtool", "new-marketing-version", string]
    }
  }
}
