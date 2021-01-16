import Foundation

public protocol ShellQuery: ShellAction {

  associatedtype ResultSuccessType
  func parseResult(output: String, error: String) -> Result<ResultSuccessType, Error>
}


extension ShellQuery {
  public func query(in context: Context) throws -> Result<ResultSuccessType, Error> {
    let logPaths = context.logPaths(for: self)
    let stdoutContents = try String(path: logPaths.stdout)
    let stderrContents = try String(path: logPaths.stderr)
    return self.parseResult(output: stdoutContents.trimmingCharacters(in: .whitespacesAndNewlines), error: stderrContents)
  }
}


public extension ShellQuery where ResultSuccessType: ShellOutputInitable {
  func parseResult(output: String, error: String) -> Result<ResultSuccessType, Error> {
    return Result {
      return try ResultSuccessType.init(shellQueryOutput: output)
    }
  }
}