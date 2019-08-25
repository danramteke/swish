import Foundation

extension SwiftAction {
  public func run(logPaths: LogPaths) throws  {
    let result = self.run()
    try result.stdout.write(to: logPaths.stdout)
    try result.stderr.write(to: logPaths.stderr)
  }
}

extension ShellAction {
  public func run() throws {
    return try self.run(in: Context.default)
  }
  public func run(in context: Context) throws {
    let logsPath = context.setupLogs(for: self)
    context.presentStart(for: self)
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    process.standardOutput = try logsPath.stdout.fileHandleForWriting()
    process.standardError = try logsPath.stderr.fileHandleForWriting()
    process.launch()
    process.waitUntilExit()
    if 0 != process.terminationStatus {
      let error = RunError.nonZeroShell(process.terminationStatus)
      context.presentFailure(for: self, error: error)
      throw error
    } else {
      context.presentSuccess(for: self)
    }
  }
}

extension Context {
  private static var _default: Context? 
  public static var `default`: Context {
    if let _default = _default {
      return _default
    } else {
      do {
        let newContext = try Context(name: nil, output:"./.swiftybuild", dryRun: false)
        Context._default = newContext
        return newContext
      } catch {
        print("could not instantiate default Context.", error)
        exit(1)
      }
    }
  }
}