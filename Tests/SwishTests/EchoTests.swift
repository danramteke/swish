#if canImport(Combine)
import Combine
#else
import OpenCombine
#endif
import XCTest
import SwishLib

final class EchoTests: XCTestCase {
  func testEcho() throws {
    let output: CurrentValueSubject<String, Never> = .init("initial")
    try swish {
      Echo("hello").store2(in: output)
    }

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

  func testEchoLoop() throws {
    let liquids = ["water", "oil", "wine", "tea"]

    try swish {
      Echo("liquids:")
      liquids.map(Echo.init)
    }
  }

  func testEchoForEach() throws {
    let liquids = ["water", "oil", "wine", "tea"]

    try swish {
      Echo("liquids:")
      ForEach(liquids) {
        Echo($0)
      }
      ForEach(liquids) {
        Echo($0)
        Echo($0)
      }
    }
  }

  func testWithoutFunctionBuilder() throws {
    let liquids = ["water", "oil", "wine", "tea"]

    let context = Context.default
    try context.run(actions: liquids.map(Echo.init))
  }
}
