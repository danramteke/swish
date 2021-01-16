import Foundation

public func script(context: Context = .default, @ScriptBuilder _ content: () -> [Action]) throws {
  let actions: [Action] = content()
  try context.run(actions: actions)
}

@_functionBuilder
public struct ScriptBuilder {
  public init() {}
  public static func buildBlock() -> [Action] { [] }
  public static func buildBlock(_ actions: Action...) -> [Action] {
    actions
  }
}
