import SwishLib
import Version

let exportOptions = Xcodebuild.ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let targetOptions = Xcodebuild.TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")


var currentVersion: Output<Int> = .init()

//print(currentVersion)

try swish {
  Agvtool.WhatVersion()
    .store(in: currentVersion)
  Echo(String(describing: currentVersion))
  Xcodebuild.WriteExportOptions(path: "./.swish/Demo-exportOptions.plist", exportOptions: exportOptions)
  Xcodebuild.Build(targetOptions: targetOptions, destination: .generic_iOS)
  Xcodebuild.Test(targetOptions: targetOptions, destination: .generic_iOS)
}
