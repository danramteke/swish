import Foundation

public func run(_ actions: [Action]) throws {
  for action in actions {
    try action.run()
  }
}

public extension Action {
  func run() throws {
    // self.render()
    // let process = Process()
    //     process.launchPath = command
    //     process.arguments = arguments
  }
}

func shell(_ args: String...) -> Int32 {
    let task = Process()
    task.launchPath = "/usr/bin/env"
    task.arguments = args
    task.launch()
    task.waitUntilExit()
    return task.terminationStatus
}
