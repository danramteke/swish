import Foundation
import Rainbow

public func run(_ actions: [Action]) throws {
  for action in actions {
    let result = try action.run()
    if result != 0 {
      print("build failed with status".red.bold, result)
      exit(1)
    }
  }
}

public extension Action {
  func run() throws -> Int32 {
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    process.standardOutput = try FileHandle(forWritingTo: Path(".swiftybuild/stdOut.log").url)
    process.standardError = try FileHandle(forWritingTo: Path(".swiftybuild/stdErr.log").url)
    process.launch()
    process.waitUntilExit()
    
    return process.terminationStatus
  }
}
