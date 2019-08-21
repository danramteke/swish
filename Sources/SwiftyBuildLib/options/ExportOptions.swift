import Foundation

public struct ExportOptions: Codable {
  public let method: Method
  public let teamID: String
  public let generateAppStoreInformation: Bool
  public let uploadBitcode: Bool
  public let uploadSymbols: Bool

  public init(method: Method = .appstore, teamID: String, generateAppStoreInformation: Bool = true, uploadBitcode: Bool = true, uploadSymbols: Bool = true) {
    self.method = method
    self.teamID = teamID
    self.generateAppStoreInformation = generateAppStoreInformation
    self.uploadBitcode = uploadBitcode
    self.uploadSymbols = uploadSymbols
  }

  public func write(to path: Path) throws {
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    let data = try encoder.encode(self)
    try data.write(to: path)
  }
}    

extension ExportOptions {
  public enum Method: String, Codable {
    case appstore = "app-store", validation, adhoc = "ad-hoc", package, enterprise, development, developerid = "developer-id", macapplication = "mac-application"
  }
}
