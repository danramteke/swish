import Foundation
#if canImport(Combine)
import Combine
#else
import OpenCombine
#endif

public protocol ShellQuery: ShellAction {

  associatedtype ResultSuccessType
  func parseResult(output: String) -> Result<ResultSuccessType, Error>

  var publisher: CurrentValueSubject<ResultSuccessType, Never> { get }




}


extension ShellQuery {
  public func query(in context: Context = .default) throws -> Result<ResultSuccessType, Error> {
    let logPaths = context.logPaths(for: self)
    let stdoutContents = try String(path: logPaths.stdout)
    return self.parseResult(output: stdoutContents.trimmingCharacters(in: .whitespacesAndNewlines))
  }

  public func store2<ResultSuccessType: ShellOutputInitable>(in subject: CurrentValueSubject<ResultSuccessType, Never>)  -> Action {
    QueryAction2<ResultSuccessType>(shellAction: self, output: subject)
  }
}


public extension ShellQuery where ResultSuccessType: ShellOutputInitable {
  func parseResult(output: String) -> Result<ResultSuccessType, Error> {
    return Result {
      return try ResultSuccessType.init(shellQueryOutput: output)
    }
  }
}
