import Foundation

struct Script {
}


@_functionBuilder
struct ScriptBuilder {
  static func buildBlock(actions: Action...) -> [Action] {
    actions
  }
}
