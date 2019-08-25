import Foundation

extension Xcodebuild {
  public struct Build {
    public let targetOptions: TargetOptions
    public let destination: Destination

    public init(targetOptions: TargetOptions, destination: Destination) {
      self.targetOptions = targetOptions
      self.destination = destination
    }
  }
}

extension Xcodebuild.Build: ShellAction {
  public var name: String { return "Build" }
  public func render() -> [String] {
    return ["xcodebuild", "build"] + targetOptions.renderedList + ["-destination", destination.rawValue]
  }
}
