import Foundation
public struct BuildAction: Codable {
  public let targetOptions: TargetOptions
  public let destination: Destination

  public init(targetOptions: TargetOptions, destination: Destination) {
    self.targetOptions = targetOptions
    self.destination = destination
  }
}

extension BuildAction: Action {
  public func render() -> [String] {
    return ["xcodebuild", "build"] + targetOptions.renderedList + ["-destination", destination.rawValue]
  }
}
