import Foundation

extension Data {
  public init(path: Path) throws {
    try self.init(contentsOf: path.url)
  }

  public func write(to path: Path) throws {
    try self.write(to: path.url, options: .atomic)
  }
}

extension String {
  public func write(to path: Path) throws {
    try self.data(using: .utf8)!.write(to: path)
  }

  public init?(path: Path) throws {
    let data = try Data.init(contentsOf: path.url)
    self.init(data: data, encoding: .utf8)
  }
}
