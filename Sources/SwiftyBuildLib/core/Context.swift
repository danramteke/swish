import Foundation
import Rainbow

public typealias LogPaths = (cmd: Path, stdout: Path, stderr: Path)
/**
 * A `Script` represents a synchronous queue of actions to take.
 */
public class Context {
  public let name: String?
  public let output: Path
  public let logsRootPath: Path
  public var isDryRun: Bool
  public init(name: String? = nil, path: Path = "./.swiftybuild", dryRun: Bool = false) throws {
    let output = path
    self.name = name
    if let name = name {
      self.output = output + Path(name)
    } else {
      self.output = output
    }
    
    self.logsRootPath = self.output + Path("logs")
    self.isDryRun = dryRun
    try self.output.createDirectories()
    try self.logsRootPath.createDirectories()
  }
  
  public func setupLogs(for action: Action) throws -> LogPaths {
    let cmdLog: Path = self.logsRootPath + Path("\(action.name)-cmd.log")
    try cmdLog.clear()
    let stdOutLog: Path = self.logsRootPath + Path("\(action.name)-stdout.log")
    try stdOutLog.clear()
    let stdErrLog: Path = self.logsRootPath + Path("\(action.name)-stderr.log")
    try stdErrLog.clear()
    
    return (cmdLog, stdOutLog, stdErrLog)
  }
  
  func presentSuccess(for action: Action) {
    print("[".cyan + action.name + "]".cyan + " ✅  success ")
  }
  
  func presentFailure(for action: Action, error: Error) {
    print("[".cyan + action.name + "]".cyan + " 🥀 " + "\(error.localizedDescription)".red.bold )
  }
  
  func presentFailure(for action: Action, error: Error, cmd: String, stdErrString: String) {
    print("[".cyan + action.name + "]".cyan + " 🥀 " + "\(error.localizedDescription)".red.bold )
    print("[".cyan + action.name + "]".cyan + " 🥀 command was: " + cmd.lightRed)
    print("[".cyan + action.name + "]".cyan + " 🥀 error log: " + stdErrString.lightRed)
  }
  
  func presentStart(for action: Action) {
    print("[".cyan + action.name + "]".cyan + " 🛫  starting")
  }

//  func logPath(for id: Action.ID) -> Path {

//  }
  
  public func run(action: Action) throws {
    let loggroup = try self.setupLogs(for: action)
    self.presentStart(for: action)
    do {
      try action.run(in: self)
    } catch {
      let cmd = try String(path: loggroup.cmd) ?? "not found"
      let stdErrString = try String(path: loggroup.stderr) ?? "not found"
      self.presentFailure(for: action, error: error, cmd: cmd, stdErrString: stdErrString)
    }
  }
  public func run(actions: [Action]) throws {
    for action in actions {
      try self.run(action: action)
    }
  }
}
