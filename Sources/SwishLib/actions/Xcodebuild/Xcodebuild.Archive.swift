import Foundation

extension Xcodebuild {
  public struct Archive {
    public let id = ID()
    public let targetOptions: TargetOptions
    public let sdk: SDK
    public let archivePath: Path

    public init(targetOptions: TargetOptions, sdk: SDK, archivePath: Path) {
      self.targetOptions = targetOptions
      self.sdk = sdk
      self.archivePath = archivePath
    }
  }
}
extension Xcodebuild.Archive: ShellAction {
  public var name: String { return "Xcodebuild.Archive" }
  public func render() -> [String] {
    return ["xcodebuild", "archive"] + targetOptions.renderedList + ["-sdk", sdk.rawValue, "-archivePath", archivePath.absolute().path]
  }
}


