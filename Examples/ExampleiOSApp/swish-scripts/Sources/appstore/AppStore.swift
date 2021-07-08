import ArgumentParser
import MPath
import Foundation
import SwishKit

struct AppStore: ParsableCommand {

    var appDevelopmentTeam: String = "EXAMPLE1"
  
    var scheme: String = "ExampleApp"
    var tmpDir: Path { projectDir + "tmp/swish" }
    
    var archivePath: Path { tmpDir + "ExampleApp.xcarchive" }
    var xcodeprojPath: Path { projectDir + "ExampleApp.xcodeproj" }
    var exportOptionsPath: Path { tmpDir + "appstore-export-options.plist" }
    var altoolUsername: String!
    var altoolPassword: String!

    @Argument(help: "Project dir")
    var projectDir: Path = Path.current

    mutating func run() throws {
        loadAppstoreCredentials()
        try makeTmpDir()
        try archive()
        try writeExportOptions()
        try exportArchive()
        try uploadArchive()
    }

    mutating func loadAppstoreCredentials() {
        guard let username = ProcessInfo.processInfo.environment["ALTOOL_USERNAME"],
        let password = ProcessInfo.processInfo.environment["ALTOOL_PASSWORD"] else {
            fatalError("supply appstore uploader credentials in `ALTOOL_USERNAME` & `ALTOOL_PASSWORD`")
        }
        self.altoolUsername = username
        self.altoolPassword = password
    }

    var makeTmpDir: Command {
        cmd("mkdir -p \(tmpDir)", options: [])
    }

    var archive: Command {
        cmd("""
            xcrun xcodebuild -project \(xcodeprojPath) -scheme \(scheme) \
                -sdk iphoneos \
                archive -archivePath \(archivePath) \
                -allowProvisioningUpdates -allowProvisioningDeviceRegistration  
            """)
    } 

    func writeExportOptions() throws {
        struct ExportOptions: Encodable {
            let teamID: String
            let method: String = "app-store"
            let generateAppStoreInformation = true
            let uploadBitcode = true
            let uploadSymbols = true
        }

        let exportOptions = ExportOptions(teamID: self.appDevelopmentTeam)
        let plistData = try PropertyListEncoder().encode(exportOptions)
        try plistData.write(to: exportOptionsPath)
    }

    var exportArchive: Command {
        cmd("""
          xcrun xcodebuild -exportArchive -archivePath \(archivePath) \
            -exportOptionsPlist \(exportOptionsPath) \
            -exportPath \(tmpDir) \
            -allowProvisioningUpdates -allowProvisioningDeviceRegistration
          """)
    }

    var uploadArchive: Command {
        cmd("""
          xcrun altool --upload-app -t ios \
            -f \(tmpDir)/ExampleApp.ipa \
            -u \(altoolUsername!) -p @env:ALTOOL_PASSWORD
        """)
    }
}

extension Path: ExpressibleByArgument {

    public init(argument: String) {
        self.init(argument)
    }
}