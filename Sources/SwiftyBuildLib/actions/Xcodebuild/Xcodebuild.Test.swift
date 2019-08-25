extension Xcodebuild {
  public struct Test {
    public let targetOptions: TargetOptions
    public let destination: Destination

    public init(targetOptions: TargetOptions, destination: Destination) {
      self.targetOptions = targetOptions
      self.destination = destination
    }
  }
}

extension Xcodebuild.Test: ShellAction {
  public var name: String { return "Xcodebuild.Test" }
  public func render() -> [String] {
    return ["xcodebuild", "test"] + targetOptions.renderedList + ["-destination", destination.rawValue]
  }
}
