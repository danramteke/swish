import Foundation

extension ShellAction {
  public func run() throws -> Result<Void, Error> {
    try self.run(in: Context.default)
  }
  public func act() throws {
    try self.act()
  }
  public func act(in context: Context) throws {
    try self.run(in: Context.default).get()
  }
  public func run(in context: Context) throws -> Result<Void, Error> {
    Result {
      context.run(action: self)
    }
//    let logsPath = try context.setupLogs(for: self)
//    context.presentStart(for: self)
//
//    let rendered = self.render()
//    let string: String = rendered.joined(separator: "\" \"")
//    try string.write(to: logsPath.cmd)
//
//    let process = Process()
//    process.launchPath = "/usr/bin/env"
//    process.arguments = rendered
//    process.standardOutput = try logsPath.stdout.fileHandleForWriting()
//    process.standardError = try logsPath.stderr.fileHandleForWriting()
//    process.launch()
//    process.waitUntilExit()
//    if 0 != process.terminationStatus {
//      let error = RunError.nonZeroShell(process.terminationStatus)
//      context.presentFailure(for: self, error: error)
//      return .failure(error)
//    } else {
//      context.presentSuccess(for: self)
//      return .success(())
//    }
  }
}
