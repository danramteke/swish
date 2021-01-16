import Foundation

public struct Query<Output> {
  public var output: Output
}

extension Query: Action {
  public var name: String {
    "Query"
  }

  public func act() throws {

  }
}

public class Output<Value> {
  public var value: Value?

  public init() {
    value = nil
  }
}

extension ShellAction {
  public func store<Value>(in output: Output<Value>) -> Action {
    QueryAction(shellAction: self, output: output)
  }
}


class QueryAction<Value>: Action {
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
