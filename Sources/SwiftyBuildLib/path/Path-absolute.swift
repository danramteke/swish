import Foundation
extension Path {
  /// Concatenates relative paths to the current directory and derives the normalized path
  ///
  /// - Returns: the absolute path in the actual filesystem
  ///
  public func absolute() -> Path {
    if isAbsolute {
      return normalize()
    }

  let expandedPath = Path(NSString(string: self.path).expandingTildeInPath)
  if expandedPath.isAbsolute {
    return expandedPath.normalize()
  }

    return (Path.current + self).normalize()
  }

  /// Normalizes the path, this cleans up redundant ".." and ".", double slashes
  /// and resolves "~".
  ///
  /// - Returns: a new path made by removing extraneous path components from the underlying String
  ///   representation.
  ///
  public func normalize() -> Path {
    return Path(NSString(string: self.path).standardizingPath)
  }

  public var isAbsolute: Bool {
    return path.hasPrefix(Path.separator)
  }
}