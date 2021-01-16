import Foundation
import Rainbow

public enum RunError: Error, LocalizedError {
  case failedAction(String)
  case nonZeroShell(Int32)
  case queryHadNoOutput
  case parseError

  public var errorDescription: String? {
    switch self {
    case .nonZeroShell(let code):
      return "Exited with code: \(code)"
    case .failedAction(let name):
      return "failed action with name: \(name)"
    case .queryHadNoOutput:
      return "Query had no output."  
    case .parseError:
      return "Unparsable"
    }
  }
}
