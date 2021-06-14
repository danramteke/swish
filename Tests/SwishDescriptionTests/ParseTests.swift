import XCTest
import SwishDescription
import Yams

final class ParseTest: XCTestCase {

	func testParseJSON() throws {
		let json = """
		{
			"scripts": {
				"clean": "swift package clean",
				"status": "git status -b porcelain",
				"bootstrap": "swift run --package-path swift-scripts bootstrap",
			}
		}
		"""

		let description = try JSONDecoder().decode(Swish.self, from: json.data(using: .utf8)!)

		XCTAssertEqual(description.scripts.count, 3)
		XCTAssertEqual(description.scripts["clean"], "swift package clean")
		XCTAssertEqual(description.scripts["status"], "git status -b porcelain")
		XCTAssertEqual(description.scripts["bootstrap"], "swift run --package-path swift-scripts bootstrap")
	}

	func testParseYAML() throws {
		let yml = """
scripts:
  clean: "swift package clean"
  status: "git status -b porcelain"
  bootstrap: swift run --package-path swift-scripts bootstrap
"""

		let description = try YAMLDecoder().decode(Swish.self, from: yml.data(using: .utf8)!)

		XCTAssertEqual(description.scripts.count, 3)
		XCTAssertEqual(description.scripts["clean"], "swift package clean")
		XCTAssertEqual(description.scripts["status"], "git status -b porcelain")
		XCTAssertEqual(description.scripts["bootstrap"], "swift run --package-path swift-scripts bootstrap")
	}
}
