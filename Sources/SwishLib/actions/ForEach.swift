import Foundation

public struct ForEach<T>: Action {
  public func run(in context: Context) throws {
    for item in self.items {
      try context.run(actionGroupConvertibles: block(item))
    }
  }

  public let block: (T) -> [ActionGroupConvertible]
  public let items: Array<T>
  public init(_ items: Array<T>, @SwishBuilder _ block: @escaping (T) -> [ActionGroupConvertible]) {
    self.items = items
    self.block = block
  }

  public let name: String = "ForEach"
  public let id: ID = .init()
}
