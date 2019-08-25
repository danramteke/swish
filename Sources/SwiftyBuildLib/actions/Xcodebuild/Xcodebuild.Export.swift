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
  public var name: String { return "Export" }
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

// public extension Context {
//   var defaultExportDir: Path {
//     return self.output + "export"
//   }

//   func export(archivePath: String, exportDir: String?, exportOptionsNamed exportOptionsName: String, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false) throws {
//     let actualExportDir = exportDir ?? self.defaultExportDir.path
//     let exportOptionsPath = self.pathForExportOptions(named: exportOptionsName)
//     let action = ExportAction(archivePath: archivePath, exportDir: actualExportDir, exportOptionsPlistPath: exportOptionsPath, allowProvisioningUpdates: allowProvisioningUpdates, allowProvisioningDeviceRegistration: allowProvisioningDeviceRegistration)
//     try self.run(action: action)
//   }
//   func export(archivePath: String, exportDir: String, exportOptionsPlistPath: Path, allowProvisioningUpdates: Bool = false, allowProvisioningDeviceRegistration: Bool = false) throws {
//     let action = ExportAction(archivePath: archivePath, exportDir: exportDir, exportOptionsPlistPath: exportOptionsPlistPath, allowProvisioningUpdates: allowProvisioningUpdates, allowProvisioningDeviceRegistration: allowProvisioningDeviceRegistration)
//     try self.run(action: action)
//   }
// }