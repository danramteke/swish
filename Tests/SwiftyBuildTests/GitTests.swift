import XCTest
import SwiftyBuildLib

final class GitTests: XCTestCase {
    func testGitRoot() throws {
        let context = try Context(name: "testGitRoot", path: "/tmp/swiftybuild/tests/testGitRoot", dryRun: true)

        let root: Path = try Git.Root().run(in: context).get()
        XCTAssertEqual("SwiftyBuild", root.components.last)
    }


}
