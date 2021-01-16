import Foundation

public protocol ShellQuery: ShellAction {

  associatedtype ResultSuccessType
  func parseResult(output: String) -> Result<ResultSuccessType, Error>
}


extension ShellQuery {
  public func query(in context: Context = .default) throws -> Result<ResultSuccessType, Error> {
    let logPaths = context.logPaths(for: self)
    let stdoutContents = try String(path: logPaths.stdout)
    return self.parseResult(output: stdoutContents.trimmingCharacters(in: .whitespacesAndNewlines))
  }
}


public extension ShellQuery where ResultSuccessType: ShellOutputInitable {
  func parseResult(output: String) -> Result<ResultSuccessType, Error> {
    return Result {
      return try ResultSuccessType.init(shellQueryOutput: output)
    }
  }
}
