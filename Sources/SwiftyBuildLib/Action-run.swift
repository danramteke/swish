import Foundation

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
