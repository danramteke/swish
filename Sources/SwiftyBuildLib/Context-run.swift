import Foundation
import Rainbow

public typealias LogPaths = (stdout: Path, stderr: Path)
public enum RunError: Error {
  case failedAction(String)
}
extension Context {
  public func run(action: Action) throws {
    let logPaths = self.setupLogs(for: action)

    print("[\(action.name)] 🛫  starting")
    let result: Bool = try {
      if isDryRun {
        return try action.run(logPaths: logPaths)
      } else {
        if let shellAction = action as? ShellAction {
          print("[\(action.name)] " + "/usr/bin/env ".lightWhite + shellAction.render().joined(separator: " "))
        }
        
        return true
      }
    }()
    if result {
      print("[\(action.name)] ✅  success ")
    } else {
      print("[\(action.name)] 🥀 " + " failed with status: ".red.bold + "\(result)")
      throw RunError.failedAction(action.name)
    }
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
  public func run(logPaths: LogPaths) throws -> Bool {
    let result = self.run()
    try result.stdout.write(to: logPaths.stdout)
    try result.stderr.write(to: logPaths.stderr)
    return result.success
  }
}

extension ShellAction {
  public func run(logPaths: LogPaths) throws -> Bool {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    process.standardOutput = try logPaths.stdout.fileHandleForWriting()
    process.standardError = try logPaths.stderr.fileHandleForWriting()
    process.launch()
    process.waitUntilExit()
    return 0 == process.terminationStatus
  }
}
