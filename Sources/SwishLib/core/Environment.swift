import Foundation

public struct Environment {
  let processInfo: ProcessInfo
  init() {
    processInfo = ProcessInfo.processInfo
  }
  public subscript (key: String) -> String? {
    processInfo.environment[key]
  }
}
