import Foundation

public struct ExportAction: Codable {
  public let archivePath: String
  public let exportDir: String
  public let exportOptionsPlistPath: String
  public let allowProvisioningUpdates: Bool
  public let allowProvisioningDeviceRegistration: Bool

  public init(archivePath: String, exportDir: String, exportOptionsPlistPath: String, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false ) {
    self.archivePath = archivePath
    self.exportDir = exportDir
    self.exportOptionsPlistPath = exportOptionsPlistPath
    self.allowProvisioningUpdates = allowProvisioningUpdates
    self.allowProvisioningDeviceRegistration = allowProvisioningDeviceRegistration
  }
}

extension ExportAction: ShellAction {
  public var name: String { return "Export" }
  public func render() -> [String] {
    var buffer = ["xcodebuild", "-exportArchive", "-archivePath", archivePath, "-exportOptionsPlist", exportOptionsPlistPath, "-exportPath", exportDir]
    if allowProvisioningDeviceRegistration {
      buffer.append("-allowProvisioningDeviceRegistration")
    }
    if allowProvisioningUpdates {
      buffer += ["-allowProvisioningUpdates"]
    }

    return buffer
  }
}
