import Foundation

extension Array where Element: Action {
  public func dryRun() throws {
    for action in self {
      try action.dryRun()
    }
  }
}
