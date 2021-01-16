import SwiftyBuildLib

let exportOptions = Xcodebuild.ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
let options = Xcodebuild.TargetOptions(scheme: "MyScheme", workspace: "MyWorkspace")


let currentVersion = try Agvtool.WhatVersion().run()
print(currentVersion)
try exportOptions.write(to: "./.swiftybuild/Demo-exportOptions.plist")

try Xcodebuild.Build(targetOptions: options, destination: .generic_iOS).act()
try Xcodebuild.Test(targetOptions: options, destination: .generic_iOS).act()

