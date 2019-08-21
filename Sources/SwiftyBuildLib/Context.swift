import Foundation
/**
 * A `Script` represents a synchronous queue of actions to take.
 */
public struct Context {
  public let name: String?
  public let output: Path
  internal let logs: Path
  public let isDryRun: Bool
  public init(name: String? = nil, output: Path = "./.swiftybuild", dryRun: Bool = false) throws {
    self.name = name
    if let name = name {
      self.output = output + Path(name)
    } else {
      self.output = output
    }
    
    self.logs = self.output + Path("logs")
    self.isDryRun = dryRun

    guard !isDryRun else {
      return
    }

    try self.output.createDirectories()
    try self.logs.createDirectories()
  }
}

internal enum Log: String {
  case stderr, stdout
}