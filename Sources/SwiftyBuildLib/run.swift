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
    let stdOut = Pipe()
    let stdErr = Pipe()
    let process = Process()
    process.launchPath = "/usr/bin/env"
    process.arguments = self.render()
    // process.standardOutput = pipe
    // process.standardError = pipe
    process.launch()
    process.waitUntilExit()
    // let stdOutData = stdOut.fileHandleForReading.readDataToEndOfFile()
    // let stdErrData = stdErr.fileHandleForReading.readDataToEndOfFile()
    // try stdOutData.write(to: Path(".swiftybuild/stdOut.log"))
    // try stdErrData.write(to: Path(".swiftybuild/stdErr.log"))
    
    return process.terminationStatus
  }
}
