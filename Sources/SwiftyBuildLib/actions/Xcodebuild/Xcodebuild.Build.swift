import Foundation

extension Xcodebuild {
  public struct Build {
    public let targetOptions: TargetOptions
    public let destination: Destination
    public let allowProvisioningUpdates: Bool

    public init(targetOptions: TargetOptions, destination: Destination, allowProvisioningUpdates: Bool = true) {
      self.targetOptions = targetOptions
      self.destination = destination
      self.allowProvisioningUpdates = allowProvisioningUpdates
    }
  }
}

extension Xcodebuild.Build: ShellAction {
  public var name: String { return "Xcodebuild.Build" }
  public func render() -> [String] {
    var buffer = ["xcodebuild", "build"] + targetOptions.renderedList + ["-destination", destination.rawValue]
    if allowProvisioningUpdates {
      buffer += ["-allowProvisioningUpdates"]
    }
    return buffer
  }
}
