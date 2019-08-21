import Foundation

public func dryRun(_ actions: [Action]) {
  for action in actions {
    action.dryRun()
  }
}

public extension Action {
  func renderString() -> String {
    return self.render().joined(separator: " ")
  }
  
  func dryRun() {
    print(self.renderString())
  }
}
