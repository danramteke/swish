import Foundation

extension Xcodebuild {
  public struct Archive {
    public let targetOptions: TargetOptions
    public let sdk: SDK
    public let archivePath: String

    public init(targetOptions: TargetOptions, sdk: SDK, archivePath: String) {
      self.targetOptions = targetOptions
      self.sdk = sdk
      self.archivePath = archivePath
    }
  }
}
extension Xcodebuild.Archive: ShellAction {
  public var name: String { return "Archive" }
  public func render() -> [String] {
    return ["xcodebuild", "archive"] + targetOptions.renderedList + ["-sdk", sdk.rawValue, "-archivePath", archivePath]
  }
}

// public extension Context {
//   func archive(targetOptions: TargetOptions, sdk: SDK, archivePath: String) throws {
//     let action = ArchiveAction(targetOptions: targetOptions, sdk: sdk, archivePath: archivePath)
//     try self.run(action: action)
//   }
// }
