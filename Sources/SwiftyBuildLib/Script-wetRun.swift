import Foundation
import Rainbow

extension Script {
  private func logPath(action: Action, log: Log) -> Path {
    if let scriptName: String = self.name {
      return self.logs + Path("\(scriptName)-\(action.name)-\(log.rawValue).log")
    } else {
      return self.logs + Path("\(action.name)-\(log.rawValue).log")
    }
  }
  internal func wetRun() throws {
    for action in actions {
      let stdOutLog: Path = logPath(action: action, log: .stdout)
      let stdErrLog: Path = logPath(action: action, log: .stderr)
      stdErrLog.touch()
      stdOutLog.touch()
      print("[\(action.name)] 🛫  starting")
      let result = try action.run(stdOut: stdOutLog, stdErr: stdErrLog)
      if result != 0 {
        print("[\(action.name)] 🥀 " + " failed with status: ".red.bold + "\(result)")
        exit(1)
      } else {
        print("[\(action.name)] ✅  success ")
      }
    }
  }
}

public extension SwiftAction {
  func run(stdOut: Path, stdErr: Path) throws -> Int32 {
    let result = self.run()
    try result.stderr.write(to: stdErr)
    try result.stdout.write(to: stdOut)
    if result.success {
      return 0
    } else {
      return 1
    }
  }
}

public extension ShellAction {
  func run(stdOut: Path, stdErr: Path) throws -> Int32 {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    process.standardOutput = try stdOut.fileHandleForWriting()
    process.standardError = try stdErr.fileHandleForWriting()
    process.launch()
    process.waitUntilExit()
    
    return process.terminationStatus
  }
}
