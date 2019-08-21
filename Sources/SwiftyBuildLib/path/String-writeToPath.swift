import Foundation 

extension String {
  public func write(to path: Path) throws {
    try self.data(using: .utf8)!.write(to: path)
  }
}
