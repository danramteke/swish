import Foundation
extension String {
  func removing(prefix: String) -> String? {
    if let range = self.range(of: prefix) {
      let slice = self[range.upperBound...]
      return String(slice)
    } else {
      return nil
    }
  }
}
