import Foundation
import SwishKit
import XCTest
import MPath

class ShellOutputInitableTests: XCTestCase {

	enum Sample: String, StdOutputInitable {
		case a
	}

	func testRawRepresentable_initStdOutput() throws {

		XCTAssertEqual(try Sample(stdOutput: "a"), Sample.a)
		XCTAssertThrowsError(try Sample(stdOutput: "nonexisting key"))
	}

	func testArray() throws {
		XCTAssertEqual(try Array<Sample>(stdOutput: "a\na\na"), [Sample.a, Sample.a, Sample.a])
		XCTAssertEqual(try Array<Sample>(stdOutput: "a"), [Sample.a])

		XCTAssertEqual(try sh("echo a; echo a; echo a"), [Sample.a, Sample.a, Sample.a])
		XCTAssertEqual(try sh("echo a"), [Sample.a])
	}
}
