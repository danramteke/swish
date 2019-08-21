import Foundation

public struct BuildAction {
  public let targetOptions: TargetOptions
  public let destination: Destination

  public init(targetOptions: TargetOptions, destination: Destination) {
    self.targetOptions = targetOptions
    self.destination = destination
  }
}

extension BuildAction: ShellAction {
  public var name: String { return "Build" }
  public func render() -> [String] {
    return ["xcodebuild", "build"] + targetOptions.renderedList + ["-destination", destination.rawValue]
  }
}
