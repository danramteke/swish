import XCTest
import SwishLib

final class GitTests: XCTestCase {
    func testGitRoot() throws {
      let gitRootOutput: Output<Path> = .init()
      try swish {
        Git.Root().store(in: gitRootOutput)
      }
      XCTAssertTrue(gitRootOutput.didChangeFromInitialValue)
      XCTAssertEqual(gitRootOutput.value?.components.last, "Swish")
    }
}
