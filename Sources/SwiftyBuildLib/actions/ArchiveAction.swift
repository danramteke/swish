import Foundation

public struct ArchiveAction: Codable {
  public let targetOptions: TargetOptions
  public let sdk: SDK
  public let archivePath: String

  public init(targetOptions: TargetOptions, sdk: SDK, archivePath: String) {
    self.targetOptions = targetOptions
    self.sdk = sdk
    self.archivePath = archivePath
  }
}

extension ArchiveAction: ShellAction {
  public var name: String { return "Archive" }
  public func render() -> [String] {
    return ["xcodebuild", "archive"] + targetOptions.renderedList + ["-sdk", sdk.rawValue, "-archivePath", archivePath]
  }
}

