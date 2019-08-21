import SwiftyBuildLib


let exportOptions = ExportOptions(method: .appstore, teamID: "PC4GHHF42K")
// try! exportOptions.write(to: "./.swiftybuild/exportoptions.plist")

let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

// let actions: [Action] = [
//   WriteExportOptions(path: Path("./.swiftybuild/\(options.scheme!)-exportOptions.plist"), exportOptions: exportOptions),
//   BuildAction(targetOptions: options, destination: .generic_iOS),
//   BuildAction(targetOptions: options, destination: .generic_iOS),
//   ArchiveAction(targetOptions: options, sdk: .iphoneos, archivePath: "./.swiftybuild/\(options.scheme!).xcarchive"),
// ]

// try run("MyScheme", actions)

let context = try Context()
try context.build(targetOptions: options, destination: .generic_iOS)
