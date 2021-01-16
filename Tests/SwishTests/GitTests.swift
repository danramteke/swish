import XCTest
import SwishLib
import Combine

final class GitTests: XCTestCase {
    func testGitRoot() throws {
      let gitRootOutput: CurrentValueSubject<Path, Never> = .init("")
      try swish {
        Git.Root().store2(in: gitRootOutput)
      }
      XCTAssertEqual(gitRootOutput.value.components.last, "swish")
    }
}
