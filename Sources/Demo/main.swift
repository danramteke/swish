import SwiftyBuildLib

let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

let actions: [Action] = [
  BuildAction(targetOptions: options, destination: .generic_iOS),
  BuildAction(targetOptions: options, destination: .generic_iOS),
  ArchiveAction(targetOptions: options, sdk: .iphoneos, archivePath: "./.swiftybuild/\(options.scheme!).xcarchive"),
]

run(actions)