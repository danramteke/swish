import XCTest
import SwishLib
#if canImport(Combine)
import Combine
#else
import OpenCombine
#endif

final class GitTests: XCTestCase {
    func testGitRoot() throws {
      let gitRootOutput: CurrentValueSubject<Path, Never> = .init("")
      try swish {
        Git.Root().store2(in: gitRootOutput)
      }
      XCTAssertEqual(gitRootOutput.value.components.last, "swish")
    }
}
