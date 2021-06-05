import ArgumentParser
import MPath
import SwishKit

struct AppStore: ParsableCommand {
    @Argument(help: "Project directory")
    var projectDir: Path

    var appDevelopmentTeam: String = "EXAMPLE1"
  
    var scheme: String = "ExampleApp"
    var tmpDir: Path { projectDir + "tmp/swish" }
    
    var archivePath: Path { tmpDir + "ExampleApp.xcarchive" }
    var xcodeprojPath: Path { projectDir + Path("ExampleApp.xcodeproj" }
    var exportOptionsPath: Path { tmpDir + "appstore-export-options.plist"}

    mutating func run() throws {
        // try printIntro()
        try makeTmpDir()
        try archive()
        try writeExportOptions()
        try exportArchive()
        // try uploadArchive()
    }

    var makeTmpDir: Command {
        cmd("mkdir -p \(tmpDir)")
    }

    var archive: Command {
        cmd("""
            xcodebuild -project \(xcodeprojPath) -scheme \(scheme) \
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
        try plistData.write(to: expor
    }

    var exportArchive: Command {
        cmd("""
          xcodebuild -exportArchive -archivePath \(archivePath) \
            -exportOptionsPlist \(exportOptionsPath) \
            -exportPath \(tmpDir) \
            -allowProvisioningUpdates -allowProvisioningDeviceRegistration
          """
    }

}

