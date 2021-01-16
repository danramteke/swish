import XCTest
import SwishLib

final class EchoTests: XCTestCase {
  func testEcho() throws {
    let output: Output<String> = .init()
    try swish {
      Echo("hello").store(in: output)
    }
    XCTAssertTrue(output.didChangeFromInitialValue)
    XCTAssertEqual(output.value, "hello")
  }

  func testEchoRender() throws {

    let context = try Context(name: "Echo")
    let action = Echo("hello")
    try swish(context: context) {
      action
    }

    let cmdPath = context.logPaths(for: action).cmd
    XCTAssertEqual(cmdPath, ".swish/Echo/logs/00-Echo-cmd.log")

    let cmdValue = try String(path: cmdPath)
    XCTAssertEqual(cmdValue, "echo hello")
  }
}
