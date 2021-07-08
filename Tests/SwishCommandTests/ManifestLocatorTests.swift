import Foundation
import XCTest
import MPath
@testable import SwishCommand

class ManifestLocatorTests: XCTestCase {

    func testLocatesInCurrentDirectory() throws {
        try assertManifestFound(testManifestPath: Path.current + "Swish.swift")
    }

    func testLocatesInParentDirectory() throws {
        try assertManifestFound(testManifestPath: Path.current.parent() + "Swish.swift")
    }

    func testLocatesInHomeDirectory() throws {
        try assertManifestFound(testManifestPath: Path.home + "Swish.swift")
    }

    func testLocatesInHomeDirectorySwishDirectory() throws {
        try assertManifestFound(testManifestPath: Path.home + ".swish" + "Swish.swift")
    }

    private func assertManifestFound(testManifestPath: Path,
                                     file: StaticString = #file,
                                     line: UInt = #line) throws {


        try testManifestPath.parent().createDirectories()
        try sampleManifest.write(to: testManifestPath)
        defer {
            try! testManifestPath.delete()
        }

        do {
            let manifestPath = try ManifestLocator().locate(commandLineArgument: nil)

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
