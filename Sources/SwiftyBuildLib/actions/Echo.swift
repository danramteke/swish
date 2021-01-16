import Foundation

public class Echo: ShellAction {
  public let id = UUID()
  public let name: String = "Echo"
  public let string: String
  public init(_ string: String) { self.string = string }

  public func render() -> [String] {
    ["echo", string]
  }
}

public class EchoOutput<T: CustomStringConvertible & ShellOutputInitable>: ShellAction {
  public let id = UUID()
  public let name: String = "EchoOutput"
  public let output: Output<T>
  public init(_ output: Output<T>) { self.output = output }

  public func render() -> [String] {
    ["echo", output.value?.description ?? "still nil"]
  }
}


public class PrintOutput<T: CustomStringConvertible & ShellOutputInitable>: Action {
  public func run(in: Context) throws {
    print(output.value?.description ?? "still nil")
  }

  public let id = UUID()
  public let name: String = "EchoOutput"
  public let output: Output<T>
  public init(_ output: Output<T>) { self.output = output }
}
