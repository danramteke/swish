import Foundation
import XCTest
import MPath
@testable import SwishCLI

class ManifestLocatorTests: XCTestCase {

    func testLocatesInCurrentDirectory() throws {
        try assertManifestFound(testManifestPath: Path.current + "Swish.swift")
    }

    func testLocatesInParentDirectory() throws {
        let dir: Path = "/tmp/SwishTests/"
        let searchPath: Path = dir + "parent/"
        try assertManifestFound(testManifestPath: dir + "Swish.swift", searchPath: searchPath)
    }

    func testLocatesInGrandparentDirectory() throws {
        let dir: Path = "/tmp/SwishTests/"
        let searchPath: Path = dir + "grand/parent/"
        try assertManifestFound(testManifestPath: dir + "Swish.swift", searchPath: searchPath)
    }

    func testLocatesInHomeDirectory() throws {
        try assertManifestFound(testManifestPath: Path.home + "Swish.swift")
    }

    func testLocatesInHomeDirectorySwishDirectory() throws {
        try assertManifestFound(testManifestPath: Path.home + ".swish" + "Swish.swift")
    }

    private func assertManifestFound(testManifestPath: Path,
                                     searchPath: Path = .current,
                                     file: StaticString = #file,
                                     line: UInt = #line) throws {

        try testManifestPath.parent().createDirectories()
        try searchPath.createDirectories()
        try sampleManifest.write(to: testManifestPath)
        defer {
            try! testManifestPath.delete()
            try? Path("/tmp/SwishTests/").delete()
        }

        do {
            let manifestPath = try ManifestLocator(searchPath: searchPath).locate(commandLineArgument: nil)

            XCTAssertEqual(manifestPath, testManifestPath, file: file, line: line)
        } catch{
            XCTFail("got an exception: \(error)", file: file, line: line)
        }
    }

}

private let sampleManifest: String = """
let swish = Swish(scripts: [
    "status": "git status --porcelain -b"
])
"""
