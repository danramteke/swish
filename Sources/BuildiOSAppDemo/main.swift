import SwiftyBuildLib

let exportOptions = Xcodebuild.ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let targetOptions = Xcodebuild.TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")


let currentVersion = try Agvtool.WhatVersion().run()
print(currentVersion)

script {
  Xcodebuild.WriteExportOptions(path: "./.swiftybuild/Demo-exportOptions.plist", exportOptions: exportOptions)
  Xcodebuild.Build(targetOptions: targetOptions, destination: .generic_iOS)
  Xcodebuild.Test(targetOptions: targetOptions, destination: .generic_iOS)
}
