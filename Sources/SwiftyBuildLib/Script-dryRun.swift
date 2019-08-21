import Foundation
import Rainbow

extension Script {
  internal func dryRun() {
    for action in self.actions {
      action.dryRun()
    }
  }
}

public extension ShellAction {
  func renderString() -> String {
    return "/usr/bin/env ".lightWhite + self.render().joined(separator: " ")
  }
  
  func dryRun() {
    print(self.renderString())
  }
}
