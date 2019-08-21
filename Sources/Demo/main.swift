import SwiftyBuildLib


let exportOptions = ExportOptions(method: .appstore, teamID: "PC4GHHF42K")
try! exportOptions.write(to: "./.swiftybuild/exportoptions.plist")

// let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

// let actions: [Action] = [
//   BuildAction(targetOptions: options, destination: .generic_iOS),
//   BuildAction(targetOptions: options, destination: .generic_iOS),
//   ArchiveAction(targetOptions: options, sdk: .iphoneos, archivePath: "./.swiftybuild/\(options.scheme!).xcarchive"),
// ]

// run(actions)