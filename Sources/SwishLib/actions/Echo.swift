import Foundation

public struct Echo<T: CustomStringConvertible & ShellOutputInitable>: ShellAction {
  public let id = UUID()
  public let name: String = "EchoOutput"
  public let output: Output<T>
  public init(_ output: Output<T>) { self.output = output }

  public func render() -> [String] {
    ["echo", output.value?.description ?? "output is nil"]
  }
}
extension Echo where T == String {
  public init(_ string: String) { self.output = Output(string)}
}

public struct Print<T: CustomStringConvertible & ShellOutputInitable>: Action {
  public func run(in: Context) throws {
    print(output.value?.description ?? "still nil")
  }

  public let id = UUID()
  public let name: String = "EchoOutput"
  public let output: Output<T>
  public init(_ output: Output<T>) { self.output = output }
}

extension Print where T == String {
  public init(_ string: String) { self.output = Output(string)}
}
