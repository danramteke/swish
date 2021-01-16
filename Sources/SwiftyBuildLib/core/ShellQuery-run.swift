import Foundation

extension ShellQuery {

  public func run(in context: Context) throws -> Result<ResultSuccessType, Error> {
    let logsPath = try context.setupLogs(for: self)
    context.presentStart(for: self)

    let rendered = self.render()
    let string: String = rendered.joined(separator: " ")
    try string.write(to: logsPath.cmd)

    let process = Process()
    process.executableURL = URL(fileURLWithPath: "/bin/sh")
    process.arguments = rendered
    process.standardOutput = try logsPath.stdout.fileHandleForWriting()
    process.standardError = try logsPath.stderr.fileHandleForWriting()
    process.launch()
    process.waitUntilExit()
    if 0 != process.terminationStatus {
      let error = RunError.nonZeroShell(process.terminationStatus)
      context.presentFailure(for: self, error: error)
    } else {
      context.presentSuccess(for: self)
    }

    guard let stdoutContents = try String(path: logsPath.stdout) else {
      context.presentFailure(for: self, error: RunError.queryHadNoOutput)
      return Result.failure(RunError.queryHadNoOutput)
    }
    let stderrContents = try String(path: logsPath.stderr)
    return self.parseResult(output: stdoutContents, error: stderrContents)
  }
}
