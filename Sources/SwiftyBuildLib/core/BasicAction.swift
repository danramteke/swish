import Foundation

extension Action {
  public func run(in context: Context) {
    context.presentStart(for: self)
    do {
      try self.act()
    } catch {
      context.presentFailure(for: self, error: error)
    }
  }

  public func act() throws {
    try run(in: Context.default)
  }
}

