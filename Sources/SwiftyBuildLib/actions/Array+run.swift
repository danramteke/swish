import Foundation

extension Array where Element: Action {
  func dryRun() throws {
    for action in self {
      try action.dryRun()
    }
  }
}
