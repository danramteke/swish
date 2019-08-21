import SwiftyBuildLib


let exportOptions = ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

do {
let context = try Context()
try context.writeExportOptions(path: Path("./.swiftybuild/\(options.scheme!)-exportOptions.plist"), exportOptions: exportOptions)
try context.build(targetOptions: options, destination: .generic_iOS)
try context.build(targetOptions: options, destination: .generic_iOS)
} catch {
  print("Error:", error.localizedDescription)
}
