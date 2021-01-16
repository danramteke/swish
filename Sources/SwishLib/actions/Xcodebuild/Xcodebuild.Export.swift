import Foundation

extension Xcodebuild {
  public struct Export {
    public let id = ID()
    public let archivePath: Path
    public let exportDir: Path
    public let exportOptionsPlistPath: Path
    public let allowProvisioningUpdates: Bool
    public let allowProvisioningDeviceRegistration: Bool

    public init(archivePath: Path, exportDir: Path, exportOptionsPlistPath: Path, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false ) {
      self.archivePath = archivePath
      self.exportDir = exportDir
      self.exportOptionsPlistPath = exportOptionsPlistPath
      self.allowProvisioningUpdates = allowProvisioningUpdates
      self.allowProvisioningDeviceRegistration = allowProvisioningDeviceRegistration
    }

    public init(context: Context, archivePath: Path, exportDir: Path?, exportOptionsPlistPath: Path, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false) throws {
      let defaultExportDir: Path = context.output + "export"
      let actualExportDir = exportDir ?? defaultExportDir
      self.init(archivePath: archivePath, exportDir: actualExportDir, exportOptionsPlistPath: exportOptionsPlistPath, allowProvisioningUpdates: allowProvisioningUpdates, allowProvisioningDeviceRegistration: allowProvisioningDeviceRegistration)
    }
  }
}

extension Xcodebuild.Export: ShellAction {
  public var name: String { return "Xcodebuild.Export" }
  public func render() -> [String] {
    var buffer = ["xcodebuild", "-exportArchive", "-archivePath", archivePath.absolute().path, "-exportOptionsPlist", exportOptionsPlistPath.absolute().path, "-exportPath", exportDir.absolute().path]
    if allowProvisioningDeviceRegistration {
      buffer.append("-allowProvisioningDeviceRegistration")
    }
    if allowProvisioningUpdates {
      buffer += ["-allowProvisioningUpdates"]
    }

    return buffer
  }
}

