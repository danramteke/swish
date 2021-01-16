import XCTest
import SwiftyBuildLib

final class GitTests: XCTestCase {
    func testGitRoot() throws {
      var gitRootOutput: Git.Root.ResultSuccessType
      script {
        Git.Root()
      }
        let context = try Context(name: "testGitRoot", path: "/tmp/swiftybuild/tests/testGitRoot")
      context.run(actions: [Git.Root()])

//        let root: Path = try Git.Root().run(in: context).get()
//        XCTAssertEqual(root.components.last, "SwiftyBuild")
    }


}
