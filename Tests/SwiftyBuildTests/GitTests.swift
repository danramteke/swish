import XCTest
import SwiftyBuildLib

final class GitTests: XCTestCase {
    func testGitRoot() throws {
      let gitRootOutput: Output<Path> = .init()
      try script {
        Git.Root().store(in: gitRootOutput)
      }
      XCTAssertTrue(gitRootOutput.didChangeFromInitialValue)
      XCTAssertEqual(gitRootOutput.value?.components.last, "SwiftyBuild")
    }


}
