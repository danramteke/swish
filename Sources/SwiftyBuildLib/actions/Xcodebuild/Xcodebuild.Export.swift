import Foundation

extension Xcodebuild {
  public struct Export {
    public let archivePath: String
    public let exportDir: String
    public let exportOptionsPlistPath: Path
    public let allowProvisioningUpdates: Bool
    public let allowProvisioningDeviceRegistration: Bool

    public init(archivePath: String, exportDir: String, exportOptionsPlistPath: Path, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false ) {
      self.archivePath = archivePath
      self.exportDir = exportDir
      self.exportOptionsPlistPath = exportOptionsPlistPath
      self.allowProvisioningUpdates = allowProvisioningUpdates
      self.allowProvisioningDeviceRegistration = allowProvisioningDeviceRegistration
    }

    public init(context: Context, archivePath: String, exportDir: String?, exportOptionsPlistPath: Path, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false) throws {
      let defaultExportDir: Path = context.output + "export"
      let actualExportDir = exportDir ?? defaultExportDir.path
      self = Export(archivePath: archivePath, exportDir: actualExportDir, exportOptionsPlistPath: exportOptionsPlistPath, allowProvisioningUpdates: allowProvisioningUpdates, allowProvisioningDeviceRegistration: allowProvisioningDeviceRegistration)
    }
  }
}

extension Xcodebuild.Export: ShellAction {
  public var name: String { return "Xcodebuild.Export" }
  public func render() -> [String] {
    var buffer = ["xcodebuild", "-exportArchive", "-archivePath", archivePath, "-exportOptionsPlist", exportOptionsPlistPath.absolute().path, "-exportPath", exportDir]
    if allowProvisioningDeviceRegistration {
      buffer.append("-allowProvisioningDeviceRegistration")
    }
    if allowProvisioningUpdates {
      buffer += ["-allowProvisioningUpdates"]
    }

    return buffer
  }
}

