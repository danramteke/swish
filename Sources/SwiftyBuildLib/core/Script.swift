import Foundation

public func script(@ScriptBuilder _ content: () -> [Action]) {
  let actions: [Action] = content()
  Context.default.run(actions: actions)
}

@_functionBuilder
public struct ScriptBuilder {
  public init() {}
  public static func buildBlock() -> [Action] { [] }
  public static func buildBlock(_ actions: Action...) -> [Action] {
    actions
  }
}
