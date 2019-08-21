import Foundation 

extension Data {
  public func write(to path: Path) throws {
    try self.write(to: path.url, options: .atomic)
  }
}
