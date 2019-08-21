# SwiftyBuild

Who wants to use a Ruby script to upload your iOS project? Not me. Let's use Swift.

## Getting Started

In the root directory of your iOS project:

    touch Package.swift
    mkdir -p swift-scripts/appstore
    touch swift-scripts/appstore/main.swift

See below for what the `Package.swift` and `main.swift` might look like.

### Sample Package.swift

    // swift-tools-version:5.0
    // The swift-tools-version declares the minimum version of Swift required to build this package.

    import PackageDescription
    let package = Package(
        name: "SwiftScripts",

        dependencies: [
          .package(url: "https://github.com/danramteke/SwiftyBuild", .branch("master"))
        ],
        targets: [
            .target(
                name: "appstore",
                dependencies: ["SwiftyBuildLib"],
                path: "swift-scripts/appstore"),
        ]
    )

### Sample main.swift

    import SwiftyBuildLib
    import Foundation

    let exportOptions = ExportOptions(method: .appstore, teamID: "XXXXXXXXXX")
    let targetOptions = TargetOptions(project: "MyProject", scheme: "MyScheme")
    let actions: [Action] = [
      WriteExportOptions(path: "./.swiftybuild/exportOptions.plist", exportOptions: exportOptions),
      NextVersion(),
      BuildAction(targetOptions: targetOptions, destination: .generic_iOS),
      ArchiveAction(targetOptions: targetOptions, sdk: .iphoneos, archivePath: "./.swiftybuild/\(targetOptions.scheme!).xcarchive"),
      ExportAction(archivePath: "./.swiftybuild/\(targetOptions.scheme!).xcarchive", exportDir: "./.swiftybuild/", exportOptionsPlistPath: "./.swiftybuild/exportOptions.plist")
    ]

    try Script(name: targetOptions.scheme!, actions: actions, dryRun: false).run()


## Attributions

The `Path` section of code was heavily borrowed and inspired by [PathKit](https://github.com/kylef/PathKit/blob/master/Sources/PathKit.swift). The license for the borrowed code is available [here](https://github.com/kylef/PathKit/blob/master/LICENSE).