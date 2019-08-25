import SwiftyBuildLib

let exportOptions = ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")



do {
  let context = try Context()
  try exportOptions.write(to: context.output + "exportOptions.plist")
  try Xcodebuild.Build(targetOptions: options, destination: .generic_iOS).run(in: context)
  try Xcodebuild.Test(targetOptions: options, destination: .generic_iOS).run(in: context)
} catch {
  print("Error:", error.localizedDescription)
}
