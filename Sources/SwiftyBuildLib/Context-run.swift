import Foundation
import Rainbow

public typealias LogPaths = (stdout: Path, stderr: Path)
public enum RunError: Error, LocalizedError {
  case failedAction(String)
  case nonZeroShell(Int32)

  public var errorDescription: String? {
    switch self {
    case .nonZeroShell(let code):
      return "Exited with code: \(code)"
    case .failedAction(let name):
      return "failed action with name: \(name)"
    }
  }
}
extension Context {
  public func run(action: Action) throws {
    let logPaths = self.setupLogs(for: action)
    self.presentStart(for: action)
    do {
      try self.getResult(for: action, logPaths: logPaths)
      self.presentSuccess(for: action)
    } catch {
      self.presentFailure(for: action, error: error)
    }
  }

  private func getResult(for action: Action, logPaths: LogPaths) throws  {
    if isDryRun {
      if let shellAction = action as? ShellAction {
        print("[\(action.name)] " + "/usr/bin/env ".lightWhite + shellAction.render().joined(separator: " "))
      }
    } else {
      try action.run(logPaths: logPaths)
    }
  }

  private func presentSuccess(for action: Action) {
    print("[\(action.name)] ✅  success ")
  }

  private func presentFailure(for action: Action, error: Error) {
    print("[\(action.name)] 🥀 " + "\(error.localizedDescription)".red.bold )
  }

  private func presentStart(for action: Action) {
    print("[\(action.name)] 🛫  starting")
  }

  private func setupLogs(for action: Action) -> LogPaths {
    let stdOutLog: Path = self.logs + Path("\(action.name)-stdout.log")
    stdOutLog.touch()
    let stdErrLog: Path = self.logs + Path("\(action.name)-stderr.log")
    stdErrLog.touch()
    return (stdOutLog, stdErrLog)
  }
}

