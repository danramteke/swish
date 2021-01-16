import Foundation

public func swish(name: String? = nil, path: Path = "./swish", dryRun: Bool = false,  @SwishBuilder _ content: () -> [Action]) throws {

  let actions: [Action] = content()
  try Context(name: name, path: path, dryRun: dryRun).run(actions: actions)
}

public func swish(context: Context = .default, @SwishBuilder _ content: () -> [Action]) throws {
  let actions: [Action] = content()
  try context.run(actions: actions)
}
