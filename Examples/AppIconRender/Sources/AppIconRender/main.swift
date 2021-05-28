import Foundation

func printHelp() {
    print("options are:")
    print(AppIconRender.allCases.map { $0.rawValue }.joined(separator: ", "))
} 

if CommandLine.arguments.count != 2 {
    printHelp()
    exit(0)
}

guard let action = AppIconRender(rawValue: CommandLine.arguments[1]) else {
    print("could not parse \(CommandLine.arguments[1])")
    printHelp()
    exit(0)
}

try action.execute()
