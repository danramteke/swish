import Foundation

public func swish(name: String? = nil, path: Path = "./swish", dryRun: Bool = false,  @SwishBuilder _ content: () -> [ActionGroupConvertible]) throws {

  let context = try Context(name: name, path: path, dryRun: dryRun)
  try context.run(actionGroupConvertibles: content())
}

public func swish(context: Context = .default, @SwishBuilder _ content: () -> [ActionGroupConvertible]) throws {
  try context.run(actionGroupConvertibles: content())
}
