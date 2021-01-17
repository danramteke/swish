#if canImport(Combine)
import Combine
#else
import OpenCombine
#endif
import SwishLib
import Version

let exportOptions = Xcodebuild.ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let targetOptions = Xcodebuild.TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")

var currentV = CurrentValueSubject<Int, Never>(0)

var currentVersion: Output<Int> = .init()

try swish {
  Agvtool.WhatVersion()
    .store(in: currentVersion)
  Echo(String(describing: currentVersion))
  Xcodebuild.WriteExportOptions(path: "./.swish/Demo-exportOptions.plist", exportOptions: exportOptions)
  Xcodebuild.Build(targetOptions: targetOptions, destination: .generic_iOS)
  Xcodebuild.Test(targetOptions: targetOptions, destination: .generic_iOS)
}
