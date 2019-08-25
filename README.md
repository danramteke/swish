# SwiftyBuild

Who wants to use a Ruby script to upload your iOS project? Not me. Let's use Swift.

## Approach

This project aims to give a programmatic interface to common iOS build actions. 
This approach enables the full expression, such as control flow and functions without 
being limited by the cuteness of a DSL. 
(Although I suppose, this is a DSL of sorts.)

This project aims give some high level assistance (build a project and upload it to the App Store!) 
as well as expose every option that Xcode's tools give.

# Architecture

Actions are run in a context. The context provides where the logs for StandardOutput and 
StandardError are written to.


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

    do {
        try exportOptions.write(to: Context.default.output + "exportOptions.plist")
      
        try Agvtool.NextVersion().run()
        try Xcodebuild.Build(targetOptions: targetOptions, 
                             destination: .generic_iOS).run()
        try Xcodebuild.Archive(targetOptions: targetOptions, 
                               sdk: .iphoneos, 
                               archivePath: Context.default.output + Path("\(targetOptions.scheme).xcarchive")).run()
        try Xcodebuild.Export(archivePath: Context.default.output + "\(targetOptions.scheme).xcarchive", 
                              exportDir: Context.default.output, 
                              exportOptionsPlistPath: Context.default.output + "exportOptions.plist").run()

        let marketingVersion = try Agvtool.WhatMarketingVersion().run()
        let buildNumber = try Agvtool.WhatVersion().run()
        print("Built and uploaded build \(buildNumber) of version \(marketingVersion)!")

    } catch {
        print("build error", error)
    }

## More fun samples

### Setting the build number

Assuming your current marketing version is stored in a file called `marketing-version`, you can write that version to all your `Info.plist` files like so:

      let currentVersion = try String(path: "./marketing-version")!
      try Agvtool.NewMarketingVersion(currentVersion).run()

## Attributions

The `Path` section of code was heavily borrowed and inspired by [PathKit](https://github.com/kylef/PathKit/blob/master/Sources/PathKit.swift). The license for the borrowed code is available [here](https://github.com/kylef/PathKit/blob/master/LICENSE).