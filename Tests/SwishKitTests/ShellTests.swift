import Foundation
import XCTest
import SwishKit

class ShellTests: XCTestCase {

	func testEcho() throws {
		let stdout = try sh("echo example", as: String.self)
		XCTAssertEqual(stdout, "example")
	}

	func testEchoWithExportedVariable() throws {
		let stdout = try sh("export EXAMPLE=example; echo $EXAMPLE", as: String.self)
		XCTAssertEqual(stdout, "example")

		XCTAssertEqual("", try sh("echo $EXAMPLE", as: String.self), "variable isn't expected to persist across calls")
	}

	func testEchoUndeclaredVariable() throws {
		XCTAssertEqual("", try sh("echo $EXAMPLE", as: String.self))
	}

	func testEchoWithVariable() throws {
		let stdout = try sh("EXAMPLE=example; echo $EXAMPLE", as: String.self)
		XCTAssertEqual(stdout, "example")
	}
}
