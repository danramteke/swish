import Foundation

public func swish(context: Context = .default, @SwishBuilder _ content: () -> [Action]) throws {
  let actions: [Action] = content()
  try context.run(actions: actions)
}

@_functionBuilder
public struct SwishBuilder {
  public init() {}
  public static func buildBlock() -> [Action] { [] }
  public static func buildBlock(_ actions: Action...) -> [Action] {
    actions
  }

  public static func buildEither(first: Action) -> [Action]  {
    [first]
  }

  public static func buildEither(second: Action) -> [Action] {
    [second]
  }

  public static func buildIf(_ value: Action?) -> [Action] {
    if let value = value {
      return [value]
    } else {
      return []
    }
  }
}
