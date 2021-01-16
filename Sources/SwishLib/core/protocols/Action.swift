import Foundation

public protocol Action: ActionGroupConvertible {
  var name: String { get }
  func run(in: Context) throws

  var id: ID { get }
  typealias ID = UUID
}

extension Action {
  public func run() throws {
    try run(in: Context.default)
  }

  public var asActionGroup: ActionGroup {
    .init(action: self)
  }
}

extension Array: ActionGroupConvertible where Element: Action {
  public var asActionGroup: ActionGroup {
    .init(actions: self)
  }
}

public protocol ActionGroupConvertible {
  var asActionGroup: ActionGroup { get }
}

public struct ActionGroup {
  let actions: [Action]

  public init(action: Action) {
    self.actions = [action]
  }

  public init(actions: [Action]) {
    self.actions = actions
  }


}

