import Foundation
import MPath

class ManifestLocator {

    func locate(commandLineArgument: Path?) throws -> Path {
        if let commandLineFile = commandLineArgument, commandLineFile.exists {
            return commandLineFile
        } else {
            return try defaultFileOrThrow()
        }
    }

    private func defaultFileOrThrow() throws -> Path {
        if Path("Swish.swift").exists {
            return Path("Swish.swift")
        } else if Path("Swish.json").exists {
            return Path("Swish.json")
        } else if Path("Swish.yaml").exists {
            return Path("Swish.yaml")
        } else if Path("Swish.yml").exists {
            return Path("Swish.yml")
        } else {
            throw FileNotFoundError()
        }
    }
}
