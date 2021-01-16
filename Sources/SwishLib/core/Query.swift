import Foundation
import Combine

public class Output<Value: ShellOutputInitable> {
  enum State {
    case initial
    case fulfilled(Value)
  }

  var state: State = .initial

  public var value: Value? {
    didSet {
      self.didChangeFromInitialValue = true
    }
  }

  public private(set) var didChangeFromInitialValue: Bool = false

  public init() {}

  public func fulfill(_ value: Value) {
    self.state = .fulfilled(value)
  }

  public init(_ value: Value) {
    self.value = value
  }
}

extension ShellAction {
  public func store<Value: ShellOutputInitable>(in output: Output<Value>) -> Action {
    QueryAction(shellAction: self, output: output)
  }


}



class QueryAction<Value: ShellOutputInitable>: Action {
  let id = ID()
  var name: String {
    "Query:\(shellAction.name)"
  }
  let output: Output<Value>
  init(shellAction: ShellAction, output: Output<Value>) {
    self.shellAction = shellAction
    self.output = output
  }

  let shellAction: ShellAction

  func run(in context: Context) throws {
    try context.run(action: shellAction)

    let logPaths = context.logPaths(for: shellAction)

    let shellOutput = try String(path: logPaths.stdout)
    let value = try Value.init(shellQueryOutput: shellOutput)
    self.output.fulfill(value)
  }
}


class QueryAction2<Value: ShellOutputInitable>: Action {
  let id = ID()
  var name: String {
    "Query:\(shellAction.name)"
  }
  let shellAction: ShellAction
  let output: CurrentValueSubject<Value, Never>
  init(shellAction: ShellAction, output: CurrentValueSubject<Value, Never>) {
    self.shellAction = shellAction
    self.output = output
  }

  func run(in context: Context) throws {
    try context.run(action: shellAction)

    let logPaths = context.logPaths(for: shellAction)

    let shellOutput = try String(path: logPaths.stdout)
    let value = try Value.init(shellQueryOutput: shellOutput)
    self.output.send(value)
  }
}
