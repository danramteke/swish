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
      try action.run(logPaths: logPaths)
    } else {
      if let shellAction = action as? ShellAction {
        print("[\(action.name)] " + "/usr/bin/env ".lightWhite + shellAction.render().joined(separator: " "))
      }
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
    let stdOutLog: Path = logPath(action: action, log: .stdout)
    let stdErrLog: Path = logPath(action: action, log: .stderr)
    stdErrLog.touch()
    stdOutLog.touch()
    return (stdOutLog, stdErrLog)
  }

  private func logPath(action: Action, log: Log) -> Path {
    if let scriptName: String = self.name {
      return self.logs + Path("\(scriptName)-\(action.name)-\(log.rawValue).log")
    } else {
      return self.logs + Path("\(action.name)-\(log.rawValue).log")
    }
  }
}

extension SwiftAction {
  public func run(logPaths: LogPaths) throws  {
    let result = self.run()
    try result.stdout.write(to: logPaths.stdout)
    try result.stderr.write(to: logPaths.stderr)
  }
}

extension ShellAction {
  public func run(logPaths: LogPaths) throws {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    process.standardOutput = try logPaths.stdout.fileHandleForWriting()
    process.standardError = try logPaths.stderr.fileHandleForWriting()
    process.launch()
    process.waitUntilExit()
    if 0 != process.terminationStatus {
      throw RunError.nonZeroShell(process.terminationStatus)
    }
  }
}
