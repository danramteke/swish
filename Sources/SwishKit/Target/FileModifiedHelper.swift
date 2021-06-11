import Foundation
import MPath

public struct FileModifiedHelper {

  public let inputs: [Path]
  public let outputs: [Path]

  public init(inputs: [Path], outputs: [Path]) {
    self.inputs = inputs
    self.outputs = outputs
  }

  public func isOutdated() -> Bool {
    do {
      guard outputs.allExist else {
        return true
      }
      guard let maxInputDate = try inputs.map({ try $0.modificationDate() }).max() else {
        return true
      }
      guard let minOutputDate = try outputs.map({ try $0.modificationDate() }).min() else {
        return true
      }

      guard maxInputDate < minOutputDate else {
        return true
      }

      return false
    } catch {
      print("error determining modification dates, assuming Outdated", error.localizedDescription)
      return true
    }
  }
}
