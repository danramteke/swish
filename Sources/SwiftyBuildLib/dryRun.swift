import Foundation
public func dryRun(_ actions: [Action]) {
  for action in actions {
    action.dryRun()
  }
}