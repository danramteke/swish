import MPath
import ArgumentParser
import SwishKit

struct BootstrapCommand: ParsableCommand {
    @Argument(help: "Project directory")
    var projectDir: Path

    var appDevelopmentTeam: String = "EXAMPLE"
    var appBuildVersion: String = "1.0"
    var appBuildNumber: String = "1"

    mutating func run() throws {
        try sh("xcodegen -s \(projectDir + "project.yml")", env: [
            "APP_BUILD_VERSION": appBuildVersion,
            "APP_BUILD_NUMBER": appBuildNumber,
            "APP_DEVELOPMENT_TEAM": appDevelopmentTeam,
        ])
    }
}

extension Path: ExpressibleByArgument {

    public init(argument: String) {
        self.init(argument)
    }
}
