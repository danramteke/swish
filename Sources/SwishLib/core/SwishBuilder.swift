import Foundation

@_functionBuilder
public struct SwishBuilder {
  public init() {}
  public static func buildBlock() -> [ActionGroupConvertible] { [] }
  public static func buildBlock(_ actions: ActionGroupConvertible...) -> [ActionGroupConvertible] {
    actions
  }

  public static func buildBlock(_ actions: [ActionGroupConvertible]) -> [ActionGroupConvertible] {
    actions
  }

  public static func buildEither(first: ActionGroupConvertible) -> [ActionGroupConvertible]  {
    [first]
  }

  public static func buildEither(second: ActionGroupConvertible) -> [ActionGroupConvertible] {
    [second]
  }

  public static func buildIf(_ value: ActionGroupConvertible?) -> [ActionGroupConvertible] {
    if let value = value {
      return [value]
    } else {
      return []
    }
  }
}
