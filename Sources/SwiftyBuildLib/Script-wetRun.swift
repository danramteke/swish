import Foundation
import Rainbow

public func run(_ actions: [Action]) throws {
  try Script(actions).run()
}

extension Script {
  internal func wetRun() throws {
    for action in actions {
      let stdOutLog: Path = self.logs + Path("\(action.name)-stdout.log")
      let stdErrLog: Path = self.logs + Path("\(action.name)-stderr.log")
      stdErrLog.touch()
      stdOutLog.touch()
      let result = try action.run(stdOut: stdOutLog, stdErr: stdErrLog)
      if result != 0 {
        print("build failed with status".red.bold, result)
        exit(1)
      }
    }
  }
}

public extension Action {
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
