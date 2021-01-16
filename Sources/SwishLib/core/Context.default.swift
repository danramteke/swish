import Foundation

extension Context {
  private static var _default: Context? 
  public static var `default`: Context {
    get {
      if let _default = _default {
        return _default
      } else {
        do {
          let newContext = try Context(name: nil, path: "./.swish")
          Context._default = newContext
          return newContext
        } catch {
          print("Error:", error)
          fatalError("could not instantiate default Context.")
        }
      }
    }
    set {
      _default = newValue
    }
  }
}
