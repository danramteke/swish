import Foundation
import SwishKit
import XCTest
import MPath

class ShellOutputInitableTests: XCTestCase {

	enum Sample: String, StdOutputInitable, ShellOutputInitable {
		case a
	}

	func testRawRepresentable_initStdOutput() throws {

		XCTAssertEqual(try Sample(stdOutput: "a"), Sample.a)
		XCTAssertThrowsError(try Sample(stdOutput: "nonexisting key"))
	}

	func testArray() throws {
		XCTAssertEqual(try Array<Sample>(stdOutput: "a\na\na"), [Sample.a, Sample.a, Sample.a])
		XCTAssertEqual(try Array<Sample>(stdOutput: "a"), [Sample.a])

		let paths = try sh("ls", as: [Path].self)
		XCTAssertTrue(paths.contains("Package.swift"))
	}
}
