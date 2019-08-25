import SwiftyBuildLib

let exportOptions = ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let options = TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

do {
  let currentVersion = try Agvtool.WhatVersion().run()
  print(currentVersion)
  try exportOptions.write(to: "./.swiftybuild/Demo-exportOptions.plist")
  try Xcodebuild.Build(targetOptions: options, destination: .generic_iOS).run()
  try Xcodebuild.Test(targetOptions: options, destination: .generic_iOS).run()
} catch {
  print("Build Error:", error.localizedDescription)
}
