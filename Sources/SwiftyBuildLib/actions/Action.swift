import Foundation

public protocol Action: Codable {
  var name: String { get }
  func run(stdOut: Path, stdErr: Path) throws -> Int32 
  func dryRun()
}

public protocol SwiftAction: Action {
  func run() -> (success: Bool, stdout: String, stderr: String)
}

public protocol ShellAction: Action {
  func render() -> [String]
}
