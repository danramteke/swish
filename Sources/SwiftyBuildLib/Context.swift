import Foundation
import Rainbow

public typealias LogPaths = (cmd: Path, stdout: Path, stderr: Path)
/**
 * A `Script` represents a synchronous queue of actions to take.
 */
public struct Context {
  public let name: String?
  public let output: Path
  public let logs: Path
  public var isDryRun: Bool
  public init(name: String? = nil, path: Path = "./.swiftybuild", dryRun: Bool = false) throws {
    let output = path
    self.name = name
    if let name = name {
      self.output = output + Path(name)
    } else {
      self.output = output
    }
    
    self.logs = self.output + Path("logs")
    self.isDryRun = dryRun
    try self.output.createDirectories()
    try self.logs.createDirectories()
  }

  public func setupLogs(for action: Action) throws -> LogPaths {
    let cmdLog: Path = self.logs + Path("\(action.name)-cmd.log")
    try cmdLog.clear()

    let stdOutLog: Path = self.logs + Path("\(action.name)-stdout.log")
    try stdOutLog.clear()
    let stdErrLog: Path = self.logs + Path("\(action.name)-stderr.log")
    try stdErrLog.clear()

    return (cmdLog, stdOutLog, stdErrLog)
  }

  func presentSuccess(for action: Action) {
    print("[".cyan + action.name + "]".cyan + " ✅  success ")
  }

  func presentFailure(for action: Action, error: Error) {
    print("[".cyan + action.name + "]".cyan + " 🥀 " + "\(error.localizedDescription)".red.bold )
    exit(1)
  }

  func presentStart(for action: Action) {
    print("[".cyan + action.name + "]".cyan + " 🛫  starting")
  }
}
