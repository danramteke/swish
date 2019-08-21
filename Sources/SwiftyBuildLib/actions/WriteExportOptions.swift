import Foundation
import Rainbow

public struct WriteExportOptions: Codable {
  public let path: Path
  public let exportOptions: ExportOptions
  public init(path: Path, exportOptions: ExportOptions) {
    self.path = path
    self.exportOptions = exportOptions
  }
}

extension WriteExportOptions: Action {
  public var name: String { return "WriteExportOptions" }
  public func render() -> [String] {
    return ["cat", try! exportOptions.asString(), ">", path.path]
  }
}
