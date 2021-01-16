import Foundation

extension ShellQuery {

  public func query(in context: Context) throws -> Result<ResultSuccessType, Error> {
    let logPaths = context.logPaths(for: self)
    let stdoutContents = try String(path: logPaths.stdout)
    let stderrContents = try String(path: logPaths.stderr)
    return self.parseResult(output: stdoutContents, error: stderrContents)
  }
}
