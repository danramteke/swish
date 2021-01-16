import Foundation

public protocol Action {
  var name: String { get }
  func run(in: Context) throws

  var id: ID { get }
  typealias ID = UUID
}

extension Action {
  public func run() throws {
    try run(in: Context.default)
  }
}
