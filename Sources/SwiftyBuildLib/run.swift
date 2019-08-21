import Foundation
import Rainbow

public func run(_ actions: [Action]) {
  for action in actions {
    let result = action.run()
    if result != 0 {
      print("build failed with status".red.bold, result)
      exit(1)
    }
  }
}

public extension Action {
  func run() -> Int32 {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    process.launch()
    process.waitUntilExit()
    return process.terminationStatus
  }
}
