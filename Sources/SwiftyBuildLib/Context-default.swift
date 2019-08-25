import Foundation

extension Context {
  private static var _default: Context? 
  public static var `default`: Context {
    if let _default = _default {
      return _default
    } else {
      do {
        let newContext = try Context(name: nil, output:"./.swiftybuild", dryRun: false)
        Context._default = newContext
        return newContext
      } catch {
        print("could not instantiate default Context.", error)
        exit(1)
      }
    }
  }
}
