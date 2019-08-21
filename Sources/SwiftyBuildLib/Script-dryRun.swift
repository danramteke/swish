import Foundation
import Rainbow
public func dryRun(_ actions: [Action]) throws {
  try Script(actions, dryRun: true).run()
}

extension Script {
  internal func dryRun() {
    for action in self.actions {
      action.dryRun()
    }
  }
}

public extension Action {
  func renderString() -> String {
    return "/usr/bin/env ".lightWhite + self.render().joined(separator: " ")
  }
  
  func dryRun() {
    print(self.renderString())
  }
}
