import Foundation

extension Path {
  func clear() throws {
    try Data().write(to: self)
  }
  
}

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

  public init?(path: Path, trimming: Bool = true) throws {
    let data = try Data.init(contentsOf: path.url)
    guard let string = String.init(data: data, encoding: .utf8) else {
      return nil
    }
    if trimming {
      self = string.trimmingCharacters(in: .whitespacesAndNewlines) 
    } else {
      self = string
    }
  }
}
