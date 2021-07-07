import Foundation

let encoder = JSONEncoder()
//encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
let jsonData = try! encoder.encode(swish)
print(String(data: jsonData, encoding: .utf8)!)
