import SwishKit
import MPath
import Foundation


print(CommandLine.arguments)

let selfPath: Path = Path(CommandLine.arguments[0])
let scriptPath: Path

if CommandLine.arguments.count == 2 {
  scriptPath = Path(CommandLine.arguments[1])
} else if CommandLine.arguments.count == 1 {
  scriptPath = Path("swish.swift")
} else {
  print("not supported with that")
  exit(1)
}

//let scriptContents = try String(path: scriptPath)

print("scriptPath = ", scriptPath.absolute())

//try sh("swift \(scriptPath)")()

try ConcreteShellCommand("swift \(scriptPath)", shellRunner: SharedShellHelper).execute()

