import Foundation

public class Output<Value: ShellQueryOutputInitable> {
  public var value: Value? {
    didSet {
      self.didChangeFromInitialValue = true
    }
  }

  public var didChangeFromInitialValue: Bool = false

  public init() {
    self.value = nil
  }

  public init(_ value: Value) {
    self.value = value
  }
}

extension ShellAction {
  public func store<Value: ShellQueryOutputInitable>(in output: Output<Value>) -> Action {
    QueryAction(shellAction: self, output: output)
  }
}


class QueryAction<Value: ShellQueryOutputInitable>: Action {
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
    try shellAction.run(in: context)
//    context.logs(for: shellAction.id)
  }


}

//extension ShellQuery {
//  public func query(_ outputReference: inout ResultSuccessType?) {
//
//  }
//}
