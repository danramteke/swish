import Foundation

extension Context {
  private static var _default: Context? 
  public static var `default`: Context {
    get {
      if let _default = _default {
        return _default
      } else {
        do {
          let newContext = try Context(name: "default", path:"./.swish")
          Context._default = newContext
          return newContext
        } catch {
          print("could not instantiate default Context.", error)
          exit(1)
        }
      }
    }
    set {
      _default = newValue
    }
  }
}
