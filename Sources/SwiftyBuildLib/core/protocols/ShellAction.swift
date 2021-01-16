import Foundation

public protocol ShellAction: Action {
  func render() -> [String]
}

extension ShellAction {

  public func run(in context: Context) throws {
    let logPaths = context.logPaths(for: self)

    let rendered: String = self.render().joined(separator: " ")
    try rendered.write(to: logPaths.cmd)

    let process = Process()
    process.launchPath = "/bin/sh"
    process.arguments = [logPaths.cmd.absolute().path]
    process.standardOutput = try logPaths.stdout.fileHandleForWriting()
    process.standardError = try logPaths.stderr.fileHandleForWriting()
    process.launch()
    process.waitUntilExit()
    if 0 != process.terminationStatus {
      throw RunError.nonZeroShell(process.terminationStatus)
    }
  }
}
