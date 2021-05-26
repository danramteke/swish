import SwishKit
import MPath
import Foundation

print("nothing to see yet")
let ars = CommandLine.arguments
print(ars)

let scriptPath: Path

if CommandLine.arguments.count == 2 {
  scriptPath = Path(CommandLine.arguments[1])
} else if CommandLine.arguments.count == 1 {
  scriptPath = Path("swish.swift")

} else {
  print("not supported with that")
  exit(1)
}

let scriptContents = try String(path: scriptPath)



