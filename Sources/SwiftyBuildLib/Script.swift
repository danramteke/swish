import Foundation
/**
 * A `Script` represents a synchronous queue of actions to take.
 */
public struct Script {
  public let name: String?
  public let actions: [Action]
  public let output: Path
  internal let logs: Path
  public let isDryRun: Bool
  public init(name: String? = nil, actions: [Action], output: Path = "./.swiftybuild", dryRun: Bool = false) throws {
    self.name = name
    self.actions = actions
    self.output = output
    self.logs = output + "logs"
    self.isDryRun = dryRun

    guard !dryRun else {
      return
    }

    try self.output.createDirectories()
    try self.logs.createDirectories()
  }

  public func run() throws {
    if isDryRun {
      self.dryRun()
    } else {
      try self.wetRun()
    }
  }
}

internal enum Log: String {
  case stderr, stdout
}