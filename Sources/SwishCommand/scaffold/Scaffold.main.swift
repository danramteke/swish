extension Scaffold {
  static let main = """
import Foundation

let encoder = JSONEncoder()
let jsonData = try! encoder.encode(swish)
print(String(data: jsonData, encoding: .utf8)!)
"""
}
