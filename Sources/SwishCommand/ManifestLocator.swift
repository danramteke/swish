import Foundation
import MPath

class ManifestLocator {

    func locate(commandLineArgument: Path?) throws -> Path {
        if let commandLineFile = commandLineArgument, commandLineFile.exists {
            return commandLineFile
        } else {
            return try searchForFile()
        }
    }

    private func searchForFile() throws -> Path {
        if let file = recursiveParentSearch(in: Path.current) {
            return file
        } else if let file = file(in: Path.home) {
            return file
        } else if let file = file(in: Path.home + ".swish") {
            return file
        }

        throw FileNotFoundError()
    }

    private func recursiveParentSearch(in dir: Path) -> Path? {
        guard dir.exists else {
            return nil
        }

        if let file = file(in: dir) {
            return file
        }

        if "/" == dir.normalize() {
            return nil
        } else {
            return recursiveParentSearch(in: dir.parent().normalize())
        }
    }

    private func file(in dir: Path) -> Path? {

        let candidates: [Path] = ["Swish.swift",
                                  "Swish.json",
                                  "Swish.yml",
                                  "Swish.yaml"]

        for candidate in candidates {
            let fullCandidate: Path = dir + candidate
            if fullCandidate.exists && fullCandidate.isReadable {
                return fullCandidate
            }
        }

        return nil
    }
}
