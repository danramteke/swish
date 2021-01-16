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

  public let environment = Environment()

  private var actionLog: [Action] = []
  private var actionLogPaths: [Action.ID: LogPaths] = [:]
  
  public init(name: String? = nil, path: Path = "./.swish", dryRun: Bool = false) throws {
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

  private func setupLogs(for action: Action, index: Int) -> LogPaths {
    let paddedIndex: String = String(format: "%02d", index)
    let cmdLog: Path = self.logsRootPath + Path("\(paddedIndex)-\(action.name)-cmd.log")
    try? cmdLog.clear()
    let stdOutLog: Path = self.logsRootPath + Path("\(paddedIndex)-\(action.name)-stdout.log")
    try? stdOutLog.clear()
    let stdErrLog: Path = self.logsRootPath + Path("\(paddedIndex)-\(action.name)-stderr.log")
    try? stdErrLog.clear()

    actionLogPaths[action.id] = (cmdLog, stdOutLog, stdErrLog)
    return (cmdLog, stdOutLog, stdErrLog)
  }
  
  private func presentSuccess(for action: Action) {
    print("[".cyan + action.name + "]".cyan + " ✅  success ")
  }
  
  private func presentFailure(for action: Action, error: Error) {
    print("[".cyan + action.name + "]".cyan + " 🥀 " + "\(error.localizedDescription)".red.bold )
  }
  
  private func presentFailure(for action: Action, error: Error, cmd: String, stdErrString: String) {
    print("[".cyan + action.name + "]".cyan + " 🥀 " + "\(error.localizedDescription)".red.bold )
    print("[".cyan + action.name + "]".cyan + " 🥀 command was: " + cmd.lightRed)
    print("[".cyan + action.name + "]".cyan + " 🥀 error log: " + stdErrString.lightRed)
  }
  
  private func presentStart(for action: Action) {
    print("[".cyan + action.name + "]".cyan + " 🛫  starting")
  }
  
  public func logPaths(for action: Action) -> LogPaths {
    let maybeLogsPaths: LogPaths? = actionLogPaths[action.id]
    if let existingLogPaths = maybeLogsPaths {
      return existingLogPaths
    }

    let index: Int! = actionLog.firstIndex(where: { $0.id == action.id })
    let newLogsPaths = setupLogs(for: action, index: index)
    return newLogsPaths
  }
  
  public func run(action: Action) throws {
    actionLog.append(action)
    let logPaths = self.logPaths(for: action)
    self.presentStart(for: action)
    do {
      try action.run(in: self)
      self.presentSuccess(for: action)
    } catch {
      let cmd = try String(path: logPaths.cmd)
      let stdErrString = try String(path: logPaths.stderr)
      self.presentFailure(for: action, error: error, cmd: cmd, stdErrString: stdErrString)
    }
  }

  public func run(actionGroupConvertibles: [ActionGroupConvertible]) throws {
    let actionGroups: [ActionGroup] = actionGroupConvertibles.map { $0.asActionGroup }
    let actions: [Action] = actionGroups.map({ $0.actions }).flatMap { $0 }
    try self.run(actions: actions)
  }

  public func run(actions: [Action]) throws {
    for action in actions {
      try self.run(action: action)
    }
  }

  public func exit(from action: Action, message: String) {
    print("[".cyan + action.name + "]".cyan + " 💥 requested exit with message: " + message.red.bold)
  }
}
