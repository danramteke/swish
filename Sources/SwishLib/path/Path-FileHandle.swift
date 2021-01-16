import Foundation

extension Path {
  public func createDirectories() throws {
    try FileManager.default.createDirectory(atPath: self.path, withIntermediateDirectories: true)
  }

  @discardableResult
  public func touch() -> Bool {
    return FileManager.default.createFile(atPath: self.path, contents: nil)
  }

  public func fileHandleForWriting() throws -> FileHandle {
    return try FileHandle(forWritingTo: self.url)
  } 
}
