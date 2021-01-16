import Foundation

extension Xcodebuild {
  public struct WriteExportOptions: Action {
    public let name: String = "WriteExportOptions"

    public let path: Path
    public let exportOptions: Xcodebuild.ExportOptions

    public init(path: Path, exportOptions: Xcodebuild.ExportOptions) {
      self.path = path
      self.exportOptions = exportOptions
    }

    public init(path: Path, method: Xcodebuild.ExportOptions.Method = .appstore, teamID: String, generateAppStoreInformation: Bool = true, uploadBitcode: Bool = true, uploadSymbols: Bool = true) {
      self.path = path
      self.exportOptions = ExportOptions(method: method, teamID: teamID, generateAppStoreInformation: generateAppStoreInformation, uploadBitcode: uploadBitcode, uploadSymbols: uploadSymbols)

    }
    public func act() throws {
      let string = try self.exportOptions.asString()
      try string.write(to: self.path)
    }
  }
}
