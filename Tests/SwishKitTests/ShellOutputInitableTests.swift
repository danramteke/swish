import Foundation
import SwishKit
import XCTest

class ShellOutputInitableTests: XCTestCase {

	enum Sample: String, StdOutputInitable, ShellOutputInitable {
		case a
	}

	func testRawRepresentable_initStdOutput() throws {

		XCTAssertEqual(try Sample(stdOutput: "a"), Sample.a)
		XCTAssertThrowsError(try Sample(stdOutput: "nonexisting key"))
	}
}
