import XCTest
import SwiftyBuildLib

final class EchoTests: XCTestCase {
  func testEcho() throws {
    let output: Output<String> = .init()
    try script {
      Echo("hello").store(in: output)
    }
    XCTAssertTrue(output.didChangeFromInitialValue)
    XCTAssertEqual(output.value, "hello")
  }

  func testEchoRender() throws {

    let context = try Context(name: "Echo")
    let action = Echo("hello")
    try script(context: context) {
      action
    }

    let cmdPath = context.logPaths(for: action).cmd
    XCTAssertEqual(cmdPath, ".swiftybuild/Echo/logs/00-Echo-cmd.log")

    let cmdValue = try String(path: cmdPath)
    XCTAssertEqual(cmdValue, "echo hello")
  }
}
