import Foundation
import Rainbow

public struct WriteExportOptions {
  public let path: Path
  public let exportOptions: ExportOptions
  public init(path: Path, exportOptions: ExportOptions) {
    self.path = path
    self.exportOptions = exportOptions
  }
}

extension WriteExportOptions: SwiftAction {
  public var name: String { return "WriteExportOptions" }
  public func run() -> (success: Bool, stdout: String, stderr: String) {
    do {
      try exportOptions.write(to: path)
    } catch {

      return (false, "", error.localizedDescription)
    }
    return (true, "Wrote export options to \(self.path)", "")
  }

  public func dryRun() {
    print("Wrote export options to \(self.path)")
  }
}

public extension Context {
  func writeExportOptions(path: Path, exportOptions: ExportOptions) throws {
    let action = WriteExportOptions(path: path, exportOptions: exportOptions)
    try self.run(action: action)
  }
}
