import Foundation

public typealias LogPaths = (stdout: Path, stderr: Path)
/**
 * A `Script` represents a synchronous queue of actions to take.
 */
public struct Context {
  public let name: String?
  public let output: Path
  public let logs: Path
  public let isDryRun: Bool
  public init(name: String? = nil, output: Path = "./.swiftybuild", dryRun: Bool = false) throws {
    self.name = name
    if let name = name {
      self.output = output + Path(name)
    } else {
      self.output = output
    }
    
    self.logs = self.output + Path("logs")
    self.isDryRun = dryRun
    try self.output.createDirectories()
    try self.logs.createDirectories()
  }

  public func setupLogs(for action: Action) -> LogPaths {
    let stdOutLog: Path = self.logs + Path("\(action.name)-stdout.log")
    stdOutLog.touch()
    let stdErrLog: Path = self.logs + Path("\(action.name)-stderr.log")
    stdErrLog.touch()
    return (stdOutLog, stdErrLog)
  }

  func presentSuccess(for action: Action) {
    print("[\(action.name)] ✅  success ")
  }

  func presentFailure(for action: Action, error: Error) {
    print("[\(action.name)] 🥀 " + "\(error.localizedDescription)".red.bold )
  }

  func presentStart(for action: Action) {
    print("[\(action.name)] 🛫  starting")
  }
  
}
