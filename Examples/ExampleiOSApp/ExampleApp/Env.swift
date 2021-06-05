import Foundation

enum Env: String {
  case appstore
  #if DEBUG
  case unittest, dev
  #endif

  static var current: Env {
    #if DEBUG
    if ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] == nil {
      return .dev
    } else {
      return .unittest
    }
    #else
    return .appstore
    #endif
  }
}
